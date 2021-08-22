# frozen_string_literal: true

RSpec.shared_examples 'successfully_deleted' do |model_class|
  it 'redirects' do
    expect(subject).to eq(302)
  end

  it 'deletes a record' do
    expect { subject }.to change { model_class.all.count }.by(-1)
  end
end
