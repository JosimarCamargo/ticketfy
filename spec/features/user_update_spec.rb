# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Update', type: :feature do
  let(:user) { create(:user) }
  feature 'Users update email and password' do
    scenario 'success' do
      sign_in(user)
      visit users_path
      click_on 'Edit'
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Password', with: 'new_password'
      click_on 'Update User'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
