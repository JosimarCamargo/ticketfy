# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared/success_with_resource'
require_relative 'shared/successfully_created'
require_relative 'shared/successfully_updated'
require_relative 'shared/successfully_deleted'
require_relative 'shared/contexts'

RSpec.describe 'Tickets Management' do
  include_context 'do_login_first'

  let(:user) { create(:user) }

  describe 'GET /tickets' do
    let!(:resource) { create_list(:ticket, 15).last }

    context 'when listing with valid parameters' do
      before { get '/tickets' }

      it_behaves_like 'success_with_resource', %i[title content]
    end

    context 'when searching' do
      before { get '/tickets', params: { search: search_params } }

      context 'when found' do
        let(:search_params) do
          {
            id: resource.id,
            title: resource.title,
            content: resource.content,
            requester_email: resource.requester.email,
            user_assigned_email: resource.user_assigned.email
          }
        end
        it_behaves_like 'success_with_resource', %i[title content id]
      end

      context 'when nothing is found' do
        let(:search_params) do
          {
            id: '123321',
            title: '123321',
            content: '123321',
            requester_email: '123321',
            user_assigned_email: '123321'
          }
        end

        it 'returns 200' do
          expect(response).to have_http_status(:ok)
        end

        xit "doesn't includes at response the resource id" do
          expect(response.body).not_to include(resource.id.to_s)
        end
      end
    end
  end

  describe 'GET /tickets/:id' do
    let!(:resource) { create(:ticket_with_replies) }

    before do
      get "/tickets/#{resource_id}"
    end

    context 'when find the ticket' do
      let(:resource_id) { resource.id }
      it_behaves_like 'success_with_resource', %i[title content]

      it 'shows ticket body' do
        expect(response.body).to include(resource.content)
      end

      it "shows the ticket's replies body" do
        expect(response.body).to include(resource.replies.first.content)
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
      let(:ticket_params) { attributes_for(:ticket).merge(requester_id: user.id, user_assigned_id: user.id) }

      it_behaves_like 'successfully_created', Ticket

      it 'has all the attributes' do
        subject
        expect(Ticket.first).to have_attributes(ticket_params)
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
      context 'with all parameters' do
        let(:new_attributes) { attributes_for(:ticket).merge(requester_id: user.id, user_assigned_id: user.id) }
        it_behaves_like 'successfully_updated', Ticket
      end

      context 'when the user assigned is removed' do
        let(:new_attributes) { { user_assigned_id: nil } }
        it_behaves_like 'successfully_updated', Ticket, Ticket.new.attributes.except('user_assigned_id').keys
      end
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
