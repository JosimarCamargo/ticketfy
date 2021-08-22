# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared/success_with_resource'
require_relative 'shared/successfully_created'
require_relative 'shared/successfully_updated'
require_relative 'shared/successfully_deleted'
require_relative 'shared/contexts'

RSpec.describe 'Users Management' do
  include_context 'do_login_first'

  describe 'GET /users' do
    let!(:resource) { create_list(:user, 5).first }
    before { get '/users' }

    context 'with valid parameters' do
      it_behaves_like 'success_with_resource', %i[email]
    end
  end

  describe 'GET /users/:id' do
    before { get "/users/#{resource_id}" }

    context 'when find the user' do
      let!(:resource) { create(:user) }
      let(:resource_id) { resource.id }

      it_behaves_like 'success_with_resource', %i[email]
    end

    context 'when does not find the user' do
      let(:resource_id) { 9999 }

      it 'redirects' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST /users' do
    subject { post '/users/', params: { user: user_params } }

    context 'with valid parameters' do
      let(:user_params) { attributes_for(:user) }

      it_behaves_like 'successfully_created', User
    end

    context 'with invalid parameters' do
      let(:user_params) { { email: nil } }

      it 'does not creates a user' do
        expect { subject }.not_to change(User, :count)
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /users/new' do
    context 'when success' do
      subject { get '/users/new' }

      it 'returns a success' do
        expect(subject).to eq(200)
      end
    end
  end

  describe 'GET /users/:id/edit' do
    context 'when success' do
      let(:resource) { create(:user) }
      before { get "/users/#{resource.id}/edit" }

      it_behaves_like 'success_with_resource', %i[email]
    end
  end

  describe 'PUT /users/:id' do
    let(:record) { create(:user) }

    before do
      put "/users/#{record.id}", params: { user: new_attributes }
    end

    context 'with valid parameters' do
      let(:new_attributes) { { email: attributes_for(:user)[:email] } }

      it_behaves_like 'successfully_updated', User, 'encrypted_password'
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { email: nil } }

      it 'does not update the user' do
        expect(response).to have_http_status(200)
        expect(record.reload).not_to have_attributes(new_attributes)
      end
    end
  end

  describe 'DELETE /users/:id' do
    context 'when is success' do
      let!(:user) { create(:user) }

      subject do
        delete "/users/#{user.id}"
      end

      it_behaves_like 'successfully_deleted', User
    end
  end
end
