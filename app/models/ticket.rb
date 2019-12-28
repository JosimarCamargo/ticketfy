# frozen_string_literal: true

class Ticket < ApplicationRecord
  enum status: { without_status: 0, working: 1, solved: 2 }
  belongs_to :requester, class_name: 'User', foreign_key: :requester_id, inverse_of: :tickets
  belongs_to :user_assigned, class_name: 'User', foreign_key: :user_assigned_id, inverse_of: :tickets, optional: true

  validates :requester, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :title, presence: true
  validates :content, presence: true
end
