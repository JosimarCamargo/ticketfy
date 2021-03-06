# frozen_string_literal: true

# To run see the test coverage use something like: COVERAGE=true rspec
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
end

require 'spec_helper'
require 'capybara/rspec'

# sometimes 'dotenv-rails' doesn't not load  ENV DOCKER_MODE before the rspec starts,
# if so explicit export
# I will remove the 'dotenv-rails' in favor of rails credentials
if ENV['DOCKER_MODE']
  Capybara.register_driver :selenium_chrome_headless_docker_friendly do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new
    browser_options.args << '--headless'
    browser_options.args << '--disable-gpu'
    # Sandbox cannot be used inside unprivileged Docker container
    browser_options.args << '--no-sandbox'
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
  end

  Capybara.default_driver = :selenium_chrome_headless_docker_friendly
  Capybara.javascript_driver = :selenium_chrome_headless_docker_friendly
else
  require 'webdrivers/chromedriver'
  Capybara.default_driver = :selenium_chrome_headless
  Capybara.javascript_driver = :selenium_chrome_headless
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!
require 'devise'
require_relative 'support/controller_macros'
require 'faker'

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::IntegrationHelpers, type: :request

  config.extend ControllerMacros, type: :controller

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
