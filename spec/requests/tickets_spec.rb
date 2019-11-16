# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tickets' do
  before(:each) do
    user = create(:user)
    sign_in user
  end

  describe 'GET /tickets' do
    let!(:tickets) { create_list(:ticket, 5) }
    subject { get '/tickets' }

    context 'with success' do
      it 'returns a ticket list' do
        expect(subject).to eq(200)
        expect(response.body).to include(tickets.first.title)
      end
    end
  end

  describe 'GET /tickets/:id' do
    let!(:ticket) { create(:ticket) }
    subject { get "/tickets/#{ticket.id}" }

    context 'with success' do
      it 'returns a correct ticket' do
        expect(subject).to eq(200)
        expect(response.body).to include(ticket.title)
        expect(response.body).to include(ticket.content)
      end
    end
  end
end
