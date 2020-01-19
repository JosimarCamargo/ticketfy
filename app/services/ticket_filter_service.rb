# frozen_string_literal: true

class TicketFilterService
  attr_reader :filter_params
  delegate :title, :content, :status, :id, :requester_email, :user_assigned_email,
           to: :filter_params

  def self.call(filter_params = {})
    new(filter_params).call
  end

  def initialize(filter_params)
    @filter_params = OpenStruct.new(filter_params)
  end

  def call
    query = Ticket.filter_by_title(title)
                  .filter_by_content(content)
                  .filter_by_status(status)
                  .filter_by_id(id)
    query = filter_by_email_related(query)
    query.all
  end

  def filter_by_email_related(query)
    return query if emails_blank?

    if filter_by_user_assigned_email?
      query.merge(Ticket.filter_by_user_assigned_email(user_assigned_email))
    elsif filter_by_requester_email?
      query.merge(Ticket.filter_by_requester_email(requester_email))
    elsif filter_by_requester_email_or_filter_by_user_assigned_email?
      query.merge(Ticket.filter_by_email_related(requester_email, user_assigned_email))
    end
  end

  def filter_by_user_assigned_email?
    requester_email.blank? && user_assigned_email.present?
  end

  def filter_by_requester_email?
    requester_email.present? && user_assigned_email.blank?
  end

  def filter_by_requester_email_or_filter_by_user_assigned_email?
    requester_email.present? && user_assigned_email.present?
  end

  def emails_blank?
    requester_email.blank? && user_assigned_email.blank?
  end
end
