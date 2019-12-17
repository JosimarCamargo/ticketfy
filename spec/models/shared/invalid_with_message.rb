# frozen_string_literal: true

RSpec.shared_examples 'invalid_with_message' do |attribute, message|
  it "without #{attribute} is invalid and returns #{message}" do
    expect(subject).not_to be_valid
    expect(subject.errors.messages[attribute]).to eq [message]
  end
end
