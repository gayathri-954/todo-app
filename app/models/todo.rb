class Todo < ApplicationRecord
  belongs_to :user

  # Ensure every todo has a title
  validates :title, presence: true
end
