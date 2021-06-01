class Park < ApplicationRecord
  has_many :park_categories
  has_many :reviews
  has_many :bookmarks
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many_attached :photos
end
