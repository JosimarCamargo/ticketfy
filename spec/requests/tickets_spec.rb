# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared/success_with_resource'
require_relative 'shared/successfully_created'
require_relative 'shared/successfully_updated'
require_relative 'shared/successfully_deleted'
require_relative 'shared/contexts'

RSpec.describe 'Tickets Management' do
  include_context 'do_login_first'

  describe 'GET /tickets' do
    let!(:resource) { create_list(:ticket, 5).first }

    before { get '/tickets' }

    context 'with valid parameters' do
      it_behaves_like 'success_with_resource', %i[title content]
    end
  end

  describe 'GET /tickets/:id' do
    let!(:resource) { create(:ticket) }

    before do
      get "/tickets/#{resource_id}"
    end

    context 'when find the ticket' do
      let(:resource_id) { resource.id }
      it_behaves_like 'success_with_resource', %i[title content]

      it 'shows ticket body' do
        expect(response.body).to include(resource.content)
      end
    end

    context 'when does not find the ticket' do
      let(:resource_id) { 9999 }

      it 'redirects' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST /tickets' do
    subject { post '/tickets/', params: { ticket: ticket_params } }

    context 'with valid parameters' do
      let(:ticket_params) { attributes_for(:ticket) }

      it_behaves_like 'successfully_created', Ticket
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

      it { is_expected.to eq(200) }
    end
  end

  describe 'GET /tickets/:id/edit' do
    let!(:resource) { create(:ticket) }

    before do
      get "/tickets/#{resource_id}"
    end

    context 'when success' do
      let(:resource_id) { resource.id }
      it_behaves_like 'success_with_resource', %i[title content]
    end
  end

  describe 'PUT /tickets/:id' do
    let(:record) { create(:ticket) }

    before do
      put "/tickets/#{record.id}", params: { ticket: new_attributes }
    end

    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:ticket) }

      it_behaves_like 'successfully_updated', Ticket
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { title: nil } }

      it 'does not update the ticket' do
        expect(response).to have_http_status(200)
        expect(record.reload).not_to have_attributes(new_attributes)
      end
    end
  end

  describe 'DELETE /tickets/:id' do
    context 'when is success' do
      let!(:ticket) { create(:ticket) }

      subject do
        delete "/tickets/#{ticket.id}"
      end

      it_behaves_like 'successfully_deleted', Ticket
    end
  end
end
