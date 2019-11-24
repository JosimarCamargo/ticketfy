# frozen_string_literal: true

RSpec.shared_examples 'success_with_content' do
  it 'returns a resource successfully' do
    expect(subject).to eq(200)
    expect(response.body).to include(resource)
  end
end
