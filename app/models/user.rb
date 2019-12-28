# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tickets, foreign_key: :requester_id, inverse_of: :requester, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :registerable,
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable
  # Devise added validations:
  # email: presence, format(asd@asd)
  # password: presence, size(min 6 digits)
end
