# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users Management', type: :feature do
  let(:user) { create(:user) }
  feature 'User updates email and password' do
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

  feature 'User deletes account' do
    scenario 'success' do
      sign_in(user)
      visit users_path
      click_on 'Destroy'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  feature 'Users are listed and paginate' do
    let!(:user_2) { create_list(:user, 21).first }
    scenario 'success' do
      sign_in(user)
      visit users_path
      expect(page).to have_content(user_2.email)
      expect(page).to have_content('‹ Prev 1 2 Next ›')
      click_on 'Next'

      # Next Page
      expect(page).not_to have_content(user_2.email)
      expect(page).to have_content(User.last.email)
    end
  end
end
