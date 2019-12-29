# frozen_string_literal: true

module TicketHelper
  # rubocop:disable Rails/HelperInstanceVariable
  def users_all
    @users_all ||= User.all
  end
  # rubocop:enable Rails/HelperInstanceVariable
end
