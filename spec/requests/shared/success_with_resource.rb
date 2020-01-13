# frozen_string_literal: true

RSpec.shared_examples 'success_with_resource' do |attributes_to_check = []|
  it 'returns success' do
    expect(response).to have_http_status(:ok)
  end

  attributes_to_check.each do |attribute_to_check|
    it "includes at response the #{attribute_to_check}" do
      expect(response.body).to include(resource.send(attribute_to_check).to_s)
    end
  end
end
