class Park < ApplicationRecord
  has_many :park_categories
  has_many :reviews
  has_many :bookmarks
end
