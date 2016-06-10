class Passport < ActiveRecord::Base
  include Formatter

  has_many :groups
  has_many :user_passports
  has_many :users, through: :user_passports
  has_many :specials
  has_many :venues, through: :specials

  validates :name, presence: true, uniqueness: true
  validates :start, presence: true
  validates :expiration, presence: true
  validates :status, presence: true

  def self.active_passports
    where(status: "active")
  end

  def self.inactive_passports
    where.not(status: "active")
  end

end
