# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]

  # GET /tickets
  def index
    @pagy, @tickets = pagy(TicketFilterService.call(search_params[:search]))
  end

  # GET /tickets/1
  def show; end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit; end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tickets/1
  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # TODO: dry this rescue across controllers
      redirect_to tickets_url, notice: 'Ticket not found.'
    end

    def ticket_params
      params.require(:ticket).permit(:title, :content, :status, :requester_id, :user_assigned_id)
    end

    def search_params
      params.permit(search: %i[title content status id requester_email user_assigned_email])
    end
end
