# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { described_class.new(ticket_params) }
  let(:ticket_params) { attributes_for(:ticket) }
  describe '#valid? ' do
    context 'With all required parameters' do
      it { is_expected.to be_valid }
    end

    context 'when is not valid' do
      it 'without a title' do
        subject.title = nil
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:title]).to eq ["can't be blank"]
      end

      it 'without a content' do
        subject.content = nil
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:content]).to eq ["can't be blank"]
      end

      it 'without a status' do
        subject.status = nil
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:status]).to eq ["can't be blank"]
      end
    end
  end
end
