# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared/invalid_with_message'

RSpec.describe Reply do
  subject { described_class.new(reply_params) }

  describe '#valid?' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket) }

    context 'when is valid' do
      let(:reply_params) do
        attributes_for(:reply).merge(user_id: user.id, ticket_id: ticket.id)
      end

      it { is_expected.to be_valid }
    end

    context 'when is not valid' do
      context 'without content' do
        let(:reply_params) { { user_id: user.id, ticket_id: ticket.id } }
        it_behaves_like 'invalid_with_message', :content, "can't be blank"
      end

      context 'without user' do
        let(:reply_params) { attributes_for(:reply).merge(ticket_id: ticket.id) }
        it_behaves_like 'invalid_with_messages', :user, ['must exist', "can't be blank"]
      end

      context 'without ticket' do
        let(:reply_params) { attributes_for(:reply).merge(user_id: user.id) }
        it_behaves_like 'invalid_with_messages', :ticket, ['must exist', "can't be blank"]
      end
    end
  end
end
