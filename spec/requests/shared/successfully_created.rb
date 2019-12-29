# frozen_string_literal: true

RSpec.shared_examples 'successfully_created' do |model_count, model_redirect = nil|
  model_redirect ||= model_count
  it "redirects to a last #{model_redirect}" do
    expect(subject).to redirect_to(model_redirect.last)
  end

  it "creates a new #{model_count}" do
    expect { subject }.to change { model_count.all.count }.by(1)
  end
end
