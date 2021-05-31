class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :park_category
  validates :user_id, uniqueness: { scope: :park_category_id }
end
