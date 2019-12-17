# frozen_string_literal: true

RSpec.shared_examples 'successfully_updated' do |model_class|
  it 'returns success' do
    expect(response).to have_http_status(302)
  end

  it "updates the requested #{model_class} on database" do
    expect(subject).to redirect_to(record)
    record_attributes = model_class.new(new_attributes).attributes
                                   .except('created_at', 'id', 'updated_at')

    expect(record.reload).to have_attributes(record_attributes)
  end
end
