# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(user_params) }
  let(:user_params) { attributes_for(:user) }

  describe '#valid? ' do
    context 'With all required parameters' do
      it { is_expected.to be_valid }
    end

    context 'When is not valid' do
      it 'without a email' do
        subject.email = nil
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:email]).to eq ["can't be blank"]
      end

      it 'with an email has incorrect format' do
        subject.email = '123'
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:email]).to eq ['is invalid']
      end

      it 'without a password' do
        subject.password = ''
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:password]).to eq ["can't be blank"]
      end
    end
  end
end
