# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ticket creating', type: :feature do
  let(:user) { create_list(:user, 2).first }
  let(:ticket_params) { attributes_for(:ticket) }

  scenario 'valid inputs' do
    sign_in(user)
    visit new_ticket_path
    fill_in 'Title', with: ticket_params[:title]
    fill_in 'Content', with: ticket_params[:content]
    select Ticket.statuses.keys[1], from: 'Status'
    select User.last.email, from: 'ticket_requester_id'
    click_on 'Create Ticket'
    expect(page).to have_content('Ticket was successfully created.')
  end
end
