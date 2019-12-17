# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared/invalid_with_message'

RSpec.describe Ticket, type: :model do
  subject { described_class.new(ticket_params) }
  describe '#valid? ' do
    context 'With all required parameters' do
      let(:ticket_params) { attributes_for(:ticket) }
      it { is_expected.to be_valid }
    end

    context 'when is not valid' do
      context 'without title' do
        let(:ticket_params) { attributes_for(:ticket).except(:title) }
        it_behaves_like 'invalid_with_message', :title, "can't be blank"
      end

      context 'without content' do
        let(:ticket_params) { attributes_for(:ticket).except(:content) }
        it_behaves_like 'invalid_with_message', :content, "can't be blank"
      end

      context 'without status' do
        let(:ticket_params) { attributes_for(:ticket).except(:status) }
        it_behaves_like 'invalid_with_message', :status, "can't be blank"
      end
    end
  end
end
