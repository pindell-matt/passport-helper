class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :user_id, uniqueness: { scope: :group, message: "You're already a part of that group!" }
end