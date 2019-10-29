# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { described_class.new(ticket_params) }
  let(:ticket_params) { attributes_for(:ticket) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }

    context 'when title and content' do
      it { is_expected.to be_valid }
    end
  end
end
