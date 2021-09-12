# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'returns the right ticket' do
  it 'returns the right ticket' do
    expect(subject).to be_a(ActiveRecord::Relation)
    expect(subject.size).to eq(1)
    expect(subject.ids).to include(ticket1.id)
  end
end

RSpec.describe TicketFilterService do
  describe '#call' do
    subject { described_class.call(filter_params) }

    context 'when searching for all ticket params' do
      let(:ticket1) { create(:ticket) }
      let!(:ticket2) { create(:ticket, status: 'without_status') }
      let(:filter_params) do
        {
          id: ticket1.id,
          title: ticket1.title,
          content: ticket1.content,
          status: ticket1.status,
          requester_email: ticket1.requester.email,
          user_assigned_email: ticket1.user_assigned.email
        }
      end

      it_behaves_like 'returns the right ticket'
    end

    context 'when searching for title' do
      let(:ticket1) { create_list(:ticket, 2).first }
      let(:filter_params) { { title: ticket1.title } }

      it_behaves_like 'returns the right ticket'
    end

    context 'when searching for content' do
      let(:ticket1) { create_list(:ticket, 2).first }
      let(:filter_params) { { content: ticket1.content } }

      it_behaves_like 'returns the right ticket'
    end

    context 'when searching for status' do
      let(:ticket1) { create(:ticket) }
      let!(:ticket2) { create(:ticket, status: 'without_status') }
      let(:filter_params) { { status: ticket1.status } }

      it_behaves_like 'returns the right ticket'
    end

    context 'when searching for id' do
      let(:ticket1) { create_list(:ticket, 2).first }
      let(:filter_params) { { id: ticket1.id } }

      it_behaves_like 'returns the right ticket'
    end

    context 'when searching for requester_email' do
      let(:ticket1) { create_list(:ticket, 2).first }
      let(:filter_params) { { requester_email: ticket1.requester.email } }

      it_behaves_like 'returns the right ticket'
    end

    context 'when searching for user_assigned_email' do
      let(:ticket1) { create_list(:ticket, 2).first }
      let(:filter_params) { { user_assigned_email: ticket1.user_assigned.email } }

      it_behaves_like 'returns the right ticket'
    end
  end
end
