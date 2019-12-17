# frozen_string_literal: true

RSpec.shared_examples 'successfully_created' do |model_class|
  it 'redirects' do
    expect(subject).to eq(302)
  end

  it 'creates a new record' do
    expect { subject }.to change { model_class.all.count }.by(1)
  end
end
