# frozen_string_literal: true

class RepliesController < ApplicationController
  def create
    @ticket = Ticket.find(params[:ticket_id])
    reply = @ticket.replies.new(replies_params)
    reply.user = current_user
    if reply.save
      flash.notice = 'Reply was created with success!'
    else
      flash.alert = 'Please fill in all fields to create a reply'
    end
    redirect_to @ticket
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    redirect_to @reply.ticket, notice: 'Reply destroyed with success'
  end

  private
    def replies_params
      params.require(:reply).permit(:content, :ticket_id)
    end
end
