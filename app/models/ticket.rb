# frozen_string_literal: true

class Ticket < ApplicationRecord
  enum status: { without_status: 0, working: 1, solved: 2 }

  validates :title, presence: true
  validates :content, presence: true
end
