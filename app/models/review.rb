class Review < ApplicationRecord
  belongs_to :user
  belongs_to :park
  validates :rating, presence: true, inclusion: { in: (1..5).to_a }
end
