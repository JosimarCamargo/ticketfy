# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users Management' do
  before do
    # There is a default user on seed admin@ticketfy
    user = User.find_by(email: 'admin@ticketfy') || create(:user)
    sign_in user
  end

  describe 'GET /users' do
    let!(:users) { create_list(:user, 5) }
    subject { get '/users' }

    context 'with valid parameters' do
      it 'returns a user list' do
        expect(subject).to eq(200)
        expect(response.body).to include(users.first.email)
      end
    end
  end

  describe 'GET /users/:id' do
    subject { get "/users/#{user_id}" }

    context 'when find the user' do
      let!(:user) { create(:user) }
      let(:user_id) { user.id }

      it 'returns a correct user' do
        expect(subject).to eq(200)
        expect(response.body).to include(user.email)
      end
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
      subject { get "/users/#{user.id}/edit" }

      it 'returns a success response' do
        expect(subject).to eq(200)
        expect(response.body).to include(user.email)
      end
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
