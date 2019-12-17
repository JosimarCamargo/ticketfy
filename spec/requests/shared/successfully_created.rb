# frozen_string_literal: true

RSpec.shared_examples 'successfully_created' do |model_class|
  it "redirects to a last #{model_class}" do
    expect(subject).to redirect_to(model_class.last)
  end

  it "creates a new #{model_class}" do
    expect { subject }.to change { model_class.all.count }.by(1)
  end
end
