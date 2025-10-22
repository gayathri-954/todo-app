class User < ApplicationRecord
  # Devise modules (if using Devise)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add this line to associate todos with users
  has_many :todos, dependent: :destroy
end
