# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User login', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'valid inputs' do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'INVALID inputs' do
    visit root_path
    fill_in 'Email', with: 'incorrect@email.com'
    fill_in 'Password', with: 'incorrect_pass'
    click_on 'Log in'
    expect(page).to have_content('Invalid Email or password.')
    expect(page).to have_current_path(new_user_session_path)
  end
end
# TODO:
# add logout
