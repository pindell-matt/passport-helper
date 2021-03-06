class Visit < ActiveRecord::Base
  belongs_to :user_passport
  has_one :user, through: :user_passport
  belongs_to :venue

  validates :user_passport_id, uniqueness: { scope: :venue_id }

  def self.get_visit(venue, user_passport)
    find_by(venue_id: venue, user_passport_id: user_passport)
  end

  def self.average_visits
    (Visit.all.count.to_f / Venue.all.count.to_f).round(2)
  end
end
