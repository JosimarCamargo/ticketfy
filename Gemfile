# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise', '>= 4.7.1'
gem 'dotenv-rails', '~> 2.7', '>= 2.7.1'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.2'
gem 'rails', '~> 5.2.2', '>= 5.2.2.1'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'awesome_print', '~> 1.8'
  gem 'brakeman', '~> 4.6', '>= 4.6.1'
  gem 'factory_bot_rails'
  gem 'pry-byebug', '~> 3.7'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'solargraph', '~> 0.37.1'
end

group :test do
  gem 'capybara', '~> 3.28'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'shoulda-matchers'
  gem 'simplecov', '~> 0.17.1', require: false
  gem 'webdrivers', '~> 4.0'
end

group :development do
  gem 'better_errors', '~> 2.5', '>= 2.5.1'
  gem 'binding_of_caller'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'rubocop-performance', '~> 1.4', '>= 1.4.1', require: false
  gem 'rubocop-rails', '~> 2.3', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
