# frozen_string_literal: true

class TicketFilterService
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def self.call(filter_params = {})
    query = Ticket
    return query.all if filter_params.blank?

    query = query.where('title ILIKE ?', filter_params[:title])       if filter_params[:title].present?
    query = query.where('content ILIKE ?', filter_params[:content])   if filter_params[:content].present?
    query = query.where(status: filter_params[:status])               if filter_params[:status].present?
    query = query.where('tickets.id::TEXT LIKE ?', "%#{filter_params[:id]}%") if filter_params[:id].present?
    # rubocop:disable Lint/UselessAssignment
    query =
      if filter_params[:requester_email].present? && filter_params[:user_assigned_email].present?
        query.joins(:requester).joins(:user_assigned)
             .where(
               'users.email = ? OR users.email = ?',
               filter_params[:requester_email],
               filter_params[:user_assigned_email]
             )
      elsif filter_params[:requester_email].present? && filter_params[:user_assigned_email].blank?
        query.joins(:requester).where(users: { email: filter_params[:requester_email] })
      elsif filter_params[:requester_email].blank? && filter_params[:user_assigned_email].present?
        query.joins(:user_assigned).where(users: { email: filter_params[:user_assigned_email] })
      else
        query.all
      end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Lint/UselessAssignment
end
