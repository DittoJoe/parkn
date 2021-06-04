class ParkCategory < ApplicationRecord
  belongs_to :category
  belongs_to :park
  has_many :votes, dependent: :destroy
end
