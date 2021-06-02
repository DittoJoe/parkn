class Park < ApplicationRecord
  REGIONS = ["Rinkeby-Kista", "Spånga-Tensta", "Hässelby-Vällingby", "Bromma", "Kungsholmen", "Norrmalm", "Östermalm", "Södermalm", "Skärholmen", "Hägersten-Liljeholmen", "Älvsjö", "Enskede-Årsta-Vantör", "Farsta", "Skarpnäck"]
  has_many :park_categories
  has_many :reviews
  has_many :bookmarks
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many_attached :photos
  validates :address, presence: true
    include PgSearch::Model
  pg_search_scope :search_by_name_and_details,
    against: [ :name, :address, :region, :details ],
    using: {
      tsearch: { prefix: true }
    }
  validates :region, inclusion: { in: REGIONS }
end
