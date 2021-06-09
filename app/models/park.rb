class Park < ApplicationRecord
  REGIONS = ["Rinkeby-Kista", "Kungsholmen", "Norrmalm", "Östermalm", "Södermalm", "Hägersten-Älvsjö", "Enskede-Årsta-Vantör"]
  has_many :park_categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many_attached :photos
  validates :name, presence: true
    include PgSearch::Model
  pg_search_scope :search_by_name_and_details,
    against: [ :name, :address, :region, :details ],
    using: {
      tsearch: { prefix: true }
    }
  validates :region, inclusion: { in: REGIONS }

  def rating
    reviews = self.reviews
    total = 0
    reviews.each do |review|
      total += review.rating
    end
    self.rating = total / reviews.count.to_f.round(1)
  end
end

# REGIONS = ["Rinkeby-Kista", "Spånga-Tensta", "Hässelby-Vällingby", "Bromma", "Kungsholmen", "Norrmalm", "Östermalm", "Södermalm", "Skärholmen", "Hägersten-Liljeholmen", "Älvsjö", "Enskede-Årsta-Vantör", "Farsta", "Skarpnäck"]
