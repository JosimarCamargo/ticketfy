# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tickets' do
  before do
    user = create(:user)
    sign_in user
  end

  describe 'GET /tickets' do
    let!(:tickets) { create_list(:ticket, 5) }
    subject { get '/tickets' }

    context 'with valid parameters' do
      it 'returns a ticket list' do
        expect(subject).to eq(200)
        expect(response.body).to include(tickets.first.title)
      end
    end
  end

  describe 'GET /tickets/:id' do
    subject { get "/tickets/#{ticket_id}" }

    context 'when find the ticket' do
      let!(:ticket) { create(:ticket) }
      let(:ticket_id) { ticket.id }

      it 'returns a correct ticket' do
        expect(subject).to eq(200)
        expect(response.body).to include(ticket.title)
        expect(response.body).to include(ticket.content)
      end
    end

    context 'when does not find the ticket' do
      let(:ticket_id) { 9999 }

      it 'redirects' do
        expect(subject).to eq(302)
      end
    end
  end

  describe 'POST /tickets' do
    subject { post '/tickets/', params: { ticket: ticket_params } }

    context 'with valid parameters' do
      let(:ticket_params) { attributes_for(:ticket) }

      it 'creates a ticket' do
        expect { subject }.to change(Ticket, :count).by(1)
        expect(response).to redirect_to(Ticket.last)
      end
    end

    context 'with invalid parameters' do
      let(:ticket_params) { { title: nil } }

      it 'does not creates a ticket' do
        expect { subject }.not_to change(Ticket, :count)
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /tickets/new' do
    context 'when success' do
      subject { get '/tickets/new' }

      it 'returns a success' do
        expect(subject).to eq(200)
      end
    end
  end

  describe 'GET /tickets/:id/edit' do
    context 'when success' do
      let(:ticket) { create(:ticket) }
      subject { get "/tickets/#{ticket.id}/edit" }

      it 'returns a success response' do
        expect(subject).to eq(200)
        expect(response.body).to include(ticket.title)
        expect(response.body).to include(ticket.content)
      end
    end
  end

  describe 'PUT /tickets/:id' do
    let(:ticket) { create(:ticket) }

    subject do
      put "/tickets/#{ticket.id}", params: { ticket: new_attributes }
    end

    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:ticket) }

      it 'updates the requested ticket' do
        expect(subject).to redirect_to(ticket)
        ticket_attributes = Ticket.new(new_attributes).attributes
                                  .except('created_at', 'id', 'updated_at')

        expect(ticket.reload).to have_attributes(ticket_attributes)
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { title: nil } }

      it 'does not update the ticket' do
        ticket_title = ticket.title
        expect(subject).to eq(200)
        expect(ticket.reload.title).to eq ticket_title
      end
    end
  end

  describe 'DELETE /tickets/:id' do
    context 'when is success' do
      let!(:ticket) { create(:ticket) }

      subject do
        delete "/tickets/#{ticket.id}"
      end

      it 'deletes the ticket' do
        expect { subject }.to change { Ticket.count }.from(1).to(0)
        expect(subject).to eq(302)
      end
    end
  end
end