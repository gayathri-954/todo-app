# app/models/user.rb
class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Devise Token Auth for API token-based authentication
  include DeviseTokenAuth::Concerns::User

  # Association with todos
  has_many :todos, dependent: :destroy
end
