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

  scope :filter_by_title, ->(title_param) { where('title ILIKE ?', title_param) if title_param.present? }
  scope :filter_by_content, ->(content_param) { where('content ILIKE ?', content_param) if content_param.present? }
  scope :filter_by_status, ->(status_param) { where(status: status_param) if status_param.present? }
  scope :filter_by_id, ->(id_param) { where('tickets.id::TEXT LIKE ?', "%#{id_param}%") if id_param.present? }
  scope :filter_by_user_assigned_email, lambda { |user_assigned_email_param|
                                          if user_assigned_email_param.present?
                                            joins(:user_assigned).where(users: { email: user_assigned_email_param })
                                          end
                                        }
  scope :filter_by_requester_email, lambda { |requester_email_param|
                                      if requester_email_param.present?
                                        joins(:requester).where(users: { email: requester_email_param })
                                      end
                                    }
  scope :filter_by_email_related, lambda { |requester_email, user_assigned_email|
                                    joins(:requester)
                                      .joins(:user_assigned)
                                      .where('users.email = ? OR users.email = ?', requester_email, user_assigned_email)
                                  }
end
