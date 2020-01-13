# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ticket creating', type: :feature do
  let(:user) { create_list(:user, 3).first }
  let(:ticket_params) { attributes_for(:ticket) }

  scenario 'valid inputs' do
    sign_in(user)
    visit new_ticket_path
    fill_in 'Title', with: ticket_params[:title]
    fill_in 'Content', with: ticket_params[:content]
    select Ticket.statuses.keys[1], from: 'Status'
    select User.second.email, from: 'ticket_requester_id'
    click_on 'Create Ticket'
    expect(page).to have_content('Ticket was successfully created.')
  end
end

RSpec.describe 'Ticket is assigned to an user', type: :feature do
  let(:user) { create(:user) }
  let!(:user_assigned) { create(:user) }
  let(:ticket) { create(:ticket, user_assigned: nil) }

  scenario 'valid inputs' do
    sign_in(user)
    visit edit_ticket_path(ticket)
    select user_assigned.email, from: 'ticket_user_assigned_id'
    click_on 'Update Ticket'
    expect(page).to have_content('Ticket was successfully updated.')
    expect(page).to have_content("Assigned to: #{user_assigned.email}")
  end
end

RSpec.describe 'User adds a reply to ticket', type: :feature do
  let(:user) { create(:user) }
  let(:ticket) { create(:ticket) }
  let(:reply_content) { attributes_for(:reply)[:content] }

  scenario 'valid inputs' do
    sign_in(user)
    visit ticket_path(ticket)
    fill_in 'reply_content', with: reply_content
    click_on 'Create Reply'
    expect(page).to have_content('Reply was created with success!')
    expect(page).to have_content(reply_content)
  end
end

RSpec.describe 'Ticket is searched', type: :feature do
  let(:user) { create(:user) }
  let!(:ticket) { create_list(:ticket, 2).first }

  scenario 'valid inputs' do
    sign_in(user)
    visit tickets_path(form_search: true)
    fill_in 'Title', with: ticket.title
    fill_in 'Content', with: ticket.content
    select Ticket.statuses.keys[1], from: 'Status'
    select ticket.requester.email, from: 'search_requester_email'
    select ticket.user_assigned.email, from: 'search_user_assigned_email'
    click_on 'Search'
    expect(page).to have_content(ticket.title)
    expect(page).to have_content(ticket.content)
    expect(page).to have_content(ticket.id)
  end
end
