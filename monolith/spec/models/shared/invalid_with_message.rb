# frozen_string_literal: true

RSpec.shared_examples 'invalid_with_message' do |attribute, message|
  it "without #{attribute} is invalid and returns #{message}" do
    expect(subject).not_to be_valid
    expect(subject.errors.messages[attribute]).to include(message)
  end
end

RSpec.shared_examples 'invalid_with_messages' do |attribute, array_messages|
  array_messages.each do |message|
    it_behaves_like 'invalid_with_message', attribute, message
  end
end
