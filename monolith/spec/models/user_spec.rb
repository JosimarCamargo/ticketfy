# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared/invalid_with_message'

RSpec.describe User, type: :model do
  subject { described_class.new(user_params) }

  describe '#valid? ' do
    context 'With all required parameters' do
      let(:user_params) { attributes_for(:user) }
      it { is_expected.to be_valid }
    end

    context 'When is not valid' do
      context 'Without email' do
        let(:user_params) { attributes_for(:user).except(:email) }
        it_behaves_like 'invalid_with_message', :email, "can't be blank"
      end

      context 'Without a password' do
        let(:user_params) { attributes_for(:user).except(:password) }
        it_behaves_like 'invalid_with_message', :password, "can't be blank"
      end

      context 'When email has incorrect format' do
        let(:user_params) { attributes_for(:user).merge(email: 'asd') }
        it_behaves_like 'invalid_with_message', :email, 'is invalid'
      end
    end
  end
end
