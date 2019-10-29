# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(user_params) }
  let(:user_params) { attributes_for(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    context 'when has email and password' do
      it { is_expected.to be_valid }
    end

    context 'when email has incorrect format' do
      let(:user_params) { { password: '123456', email: '123' } }
      it { is_expected.to be_invalid }
    end
  end
end
