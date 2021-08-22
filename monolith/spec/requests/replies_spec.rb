# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared/successfully_created'
require_relative 'shared/successfully_deleted'
require_relative 'shared/contexts'

RSpec.describe 'Replies Management' do
  include_context 'do_login_first'

  let(:user) { create(:user) }
  let(:ticket) { create(:ticket) }

  describe 'POST /tickets/:id/replies' do
    subject { post "/tickets/#{ticket.id}/replies", params: { reply: reply_params } }

    context 'with valid parameters' do
      let(:reply_params) { attributes_for(:reply) }

      it_behaves_like 'successfully_created', Reply, Ticket

      it 'has all the attributes' do
        subject
        expect(Reply.first).to have_attributes(reply_params)
      end
    end

    context 'with invalid parameters' do
      let(:reply_params) { { content: nil } }

      it 'does not creates a ticket' do
        expect { subject }.not_to change(Reply, :count)
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE /replies/:id' do
    context 'when is success' do
      let!(:reply) { create(:reply) }

      subject do
        delete "/replies/#{reply.id}"
      end

      it_behaves_like 'successfully_deleted', Reply
    end
  end
end
