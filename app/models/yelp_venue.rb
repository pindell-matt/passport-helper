class YelpVenue < ActiveRecord::Base
  belongs_to :venue
  validates :venue_id,   presence: true
  validates :yelp_id,    presence: true
  validates :rating_url, presence: true
  validates :yelp_url,   presence: true
  validates :venue_id,   uniqueness: { scope: :yelp_id }

  def self.up_visits(user_passport)
    joins_visits(user_passport).each { |tag| tag.prepend("#") }.join(", ")
  end

  def self.up_visits_group(user_passport)
    user_passport.map do |up|
      joins_visits(up).each { |tag| tag.prepend("#") << "-#{up.user_id}" }.compact
    end.flatten.join(", ")
  end

  def self.venue_id_for_visit(yelp_id)
    find_by(yelp_id: yelp_id).venue_id
  end

  private

  def self.joins_visits(user_passport)
    joins(venue: [:visits])
    .where(visits: { user_passport_id: user_passport.id})
    .pluck("yelp_id")
  end
end
