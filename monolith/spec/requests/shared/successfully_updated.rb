# frozen_string_literal: true

RSpec.shared_examples 'successfully_updated' do |model_class, *attributes_exceptions|
  it 'returns success' do
    expect(response).to have_http_status(302)
  end

  it "updates the requested #{model_class} on database" do
    attributes_exceptions << %w[created_at id updated_at]
    attributes_exceptions.flatten!
    expect(subject).to redirect_to(record)
    record_attributes = model_class.new(new_attributes).attributes.except(*attributes_exceptions)

    expect(record.reload).to have_attributes(record_attributes)
  end
end
