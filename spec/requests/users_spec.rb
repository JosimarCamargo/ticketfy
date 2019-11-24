# frozen_string_literal: true

require 'rails_helper'
require_relative 'load_shared'

RSpec.describe 'Users Management' do
  include_context 'do_login_first'

  describe 'GET /users' do
    let!(:resource) { create_list(:user, 5).first.email }
    subject { get '/users' }

    context 'with valid parameters' do
      it_behaves_like 'success_with_content'
    end
  end

  describe 'GET /users/:id' do
    subject { get "/users/#{user_id}" }

    context 'when find the user' do
      let!(:user) { create(:user) }
      let(:user_id) { user.id }
      let(:resource) { user.email }

      it_behaves_like 'success_with_content'
    end

    context 'when does not find the user' do
      let(:user_id) { 9999 }

      it 'redirects' do
        expect(subject).to eq(302)
      end
    end
  end

  describe 'POST /users' do
    subject { post '/users/', params: { user: user_params } }

    context 'with valid parameters' do
      let(:user_params) { attributes_for(:user) }

      it 'creates a user' do
        expect { subject }.to change(User, :count).by(1)
        expect(response).to redirect_to(User.last)
      end
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
      let(:user) { create(:user) }
      let(:resource) { user.email }
      subject { get "/users/#{user.id}/edit" }

      it_behaves_like 'success_with_content'
    end
  end

  describe 'PUT /users/:id' do
    let(:user) { create(:user) }

    subject do
      put "/users/#{user.id}", params: { user: new_attributes }
    end

    context 'with valid parameters' do
      let(:new_attributes) { { email: attributes_for(:user)[:email] } }

      it 'updates the requested user' do
        expect(subject).to redirect_to(user)
        expect(user.reload).to have_attributes(new_attributes)
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { email: nil } }

      it 'does not update the user' do
        expect(subject).to eq(200)
        expect(user.reload).not_to have_attributes(new_attributes)
      end
    end
  end

  describe 'DELETE /users/:id' do
    context 'when is success' do
      let!(:user) { create(:user) }

      subject do
        delete "/users/#{user.id}"
      end

      it 'deletes the user' do
        expect { subject }.to change { User.count }.from(2).to(1)
        expect(subject).to eq(302)
      end
    end
  end
end
