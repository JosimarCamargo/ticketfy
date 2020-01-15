# frozen_string_literal: true

class TicketFilterService
  attr_reader :filter_params
  delegate :title, :content, :status, :id, :requester_email, :user_assigned_email,
           to: :filter_params

  def self.call(filter_params = {})
    new(filter_params).call
  end

  def initialize(filter_params)
    @query = Ticket
    @filter_params = OpenStruct.new(filter_params)
  end

  def call
    @query = search_by_title
    @query = search_by_content
    @query = search_by_status
    @query = search_by_id
    @query = search_by_user_email
    @query.all
  end

  def search_by_user_email
    if search_by_user_assigned_email?
      @query.joins(:user_assigned).where(users: { email: user_assigned_email })
    elsif search_by_requester_email?
      @query.joins(:requester).where(users: { email: requester_email })
    elsif search_by_requester_email_or_search_by_user_assigned_email?
      @query.joins(:requester).joins(:user_assigned)
            .where('users.email = ? OR users.email = ?', requester_email, user_assigned_email)
    else
      @query
    end
  end

  def search_by_title
    return @query if title.nil?

    @query.where('title ILIKE ?', title)
  end

  def search_by_content
    return @query if content.nil?

    @query.where('content ILIKE ?', content)
  end

  def search_by_status
    return @query if status.nil?

    @query.where(status: status)
  end

  def search_by_id
    return @query if id.nil?

    @query.where('tickets.id::TEXT LIKE ?', "%#{id}%")
  end

  def search_by_user_assigned_email?
    requester_email.nil? && user_assigned_email.present?
  end

  def search_by_requester_email?
    requester_email.present? && user_assigned_email.nil?
  end

  def search_by_requester_email_or_search_by_user_assigned_email?
    requester_email.present? && user_assigned_email.present?
  end
end
