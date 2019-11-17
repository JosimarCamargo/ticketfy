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

  describe 'POST /tickets' do
    context 'when success' do
      let(:ticket_params) { attributes_for(:ticket) }

      subject { post '/tickets/', params: { ticket: ticket_params } }

      it 'creates a ticket' do
        expect { subject }.to change(Ticket, :count).by(1)
        expect(response).to redirect_to(Ticket.last)
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

      it 'returns a success' do
        expect(subject).to eq(200)
        expect(response.body).to include(ticket.title)
        expect(response.body).to include(ticket.content)
      end
    end
  end

  describe 'PUT /tickets/:id' do
    context 'when is success' do
      let(:new_attributes) { attributes_for(:ticket) }
      let(:ticket) { create(:ticket) }

      subject do
        put "/tickets/#{ticket.id}", params: { ticket: new_attributes }
      end

      it 'updates the requested ticket' do
        expect(subject).to redirect_to(ticket)
        ticket_attributes = Ticket.new(new_attributes).attributes
                                  .except('created_at', 'id', 'updated_at')

        expect(ticket.reload).to have_attributes(ticket_attributes)
      end
    end
  end

  describe 'DELETE /tickets/:id' do
    context 'when is success' do
      let!(:ticket) { create(:ticket) }

      subject do
        delete "/tickets/#{ticket.id}"
      end

      it 'returns success' do
        expect(subject).to eq(302)
      end

      it 'deletes a record' do
        expect { subject }.to change { Ticket.count }.from(1).to(0)
      end
    end
  end
end
