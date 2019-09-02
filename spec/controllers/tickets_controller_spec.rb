# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  login_user

  let(:valid_attributes) do
    attributes_for(:ticket)
  end

  let(:invalid_attributes) do
    attributes_for(:ticket).except(:title)
  end

  let(:ticket) { FactoryBot.create(:ticket) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: ticket.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: ticket.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Ticket' do
        expect do
          post :create, params: { ticket: valid_attributes }
        end.to change(Ticket, :count).by(1)
      end

      it 'redirects to the created ticket' do
        post :create, params: { ticket: valid_attributes }
        expect(response).to redirect_to(Ticket.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { ticket: { title: nil } }
        expect(response).to be_successful
      end

      it 'does NOT create a new ticket' do
        expect do
          post :create, params: { ticket: { title: nil } }
        end.not_to change(Ticket, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:ticket)
      end

      it 'updates the requested ticket' do
        put :update, params: { id: ticket.to_param, ticket: new_attributes }
        expect(ticket.reload).to have_attributes(Ticket.new(new_attributes).attributes.except('created_at', 'id', 'updated_at'))
      end

      it 'redirects to the ticket' do
        put :update, params: { id: ticket.to_param, ticket: valid_attributes }
        expect(response).to redirect_to(ticket)
      end
    end

    context 'with invalid params' do
      it 'redirects to ticket without losing title' do
        ticket_title = ticket.title
        put :update, params: { id: ticket.to_param, ticket: invalid_attributes }
        expect(response).to redirect_to(ticket)
        expect(ticket.reload).to have_attributes(title: ticket_title)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested ticket' do
      ticket = Ticket.create! valid_attributes
      expect do
        delete :destroy, params: { id: ticket.to_param }
      end.to change(Ticket, :count).by(-1)
    end

    it 'redirects to the tickets list' do
      ticket = Ticket.create! valid_attributes
      delete :destroy, params: { id: ticket.to_param }
      expect(response).to redirect_to(tickets_url)
    end
  end
end
