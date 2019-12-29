# frozen_string_literal: true

class Reply < ApplicationRecord
  belongs_to :ticket, inverse_of: :replies
  belongs_to :user, inverse_of: :replies

  validates :content, presence: true
  validates :ticket, presence: true
  validates :user, presence: true
end
