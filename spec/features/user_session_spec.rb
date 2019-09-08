# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Session', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  feature 'Users Login' do
    scenario 'login valid inputs' do
      visit root_path # or user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'login INVALID inputs' do
      visit root_path
      fill_in 'Email', with: 'incorrect@email.com'
      fill_in 'Password', with: 'incorrect_pass'
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password.')
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  feature 'Users Logout' do
    scenario 'success' do
      sign_in(user) # sign_in(user) is a Devise::Test::IntegrationHelpers
      visit root_path
      skip 'Add Navbar with logout button'
    end
  end
end
