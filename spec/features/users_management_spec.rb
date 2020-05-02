# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users Management', type: :feature do
  let(:user) { create(:user) }
  feature 'User updates email and password' do
    let(:new_email) { 'new@email.com' }
    let(:new_password) { 'new_password' }
    scenario 'success' do
      sign_in(user)
      visit users_path
      find("a[href='#{edit_user_path(user.id)}']").click # Edit Button
      fill_in 'Email', with: new_email
      fill_in 'Password', with: new_password
      click_on 'Update User'
      expect(user.reload.email).to eq(new_email)
      expect(user.valid_password?(new_password)).to be true
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  feature 'User deletes account' do
    scenario 'success' do
      sign_in(user)
      visit users_path
      find("a[href='#{user_path(user.id)}'][data-method='delete']").click # Delete Button
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(User.find_by(id: user.id)).to be nil
    end
  end

  feature 'Users are listed and paginated' do
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
