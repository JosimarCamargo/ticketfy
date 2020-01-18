# frozen_string_literal: true

class Ticket < ApplicationRecord
  enum status: { without_status: 0, working: 1, solved: 2 }
  belongs_to :requester, class_name: 'User', foreign_key: :requester_id, inverse_of: :tickets
  belongs_to :user_assigned, class_name: 'User', foreign_key: :user_assigned_id, inverse_of: :tickets, optional: true
  has_many :replies, dependent: :destroy

  validates :requester, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :title, presence: true
  validates :content, presence: true

  scope :search_by_title, ->(title_param) { where('title ILIKE ?', title_param) if title_param }
  scope :search_by_content, ->(content_param) { where('content ILIKE ?', content_param) if content_param }
  scope :search_by_status, ->(status_param) { where(status: status_param) if status_param }
  scope :search_by_id, ->(id_param) { where('tickets.id::TEXT LIKE ?', "%#{id_param}%") if id_param }
end
