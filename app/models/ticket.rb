# frozen_string_literal: true

class Ticket < ApplicationRecord
  enum status: { without_status: 0, working: 1, solved: 2 }
  belongs_to :requester, class_name: 'User', foreign_key: :requester_id

  validates :requester, presence: true
  validates :status, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
