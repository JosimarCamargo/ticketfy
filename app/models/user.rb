# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :registerable,
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable
  # Devise added validations:
  # email: presence, format(asd@asd)
  # password: presence, size(min 6 digits)
end
