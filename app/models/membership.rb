class Membership < ActiveRecord::Base

  scope :confirmed, where(:confirmed => true)
  scope :unconfirmed, where(:confirmed => [nil, false])

  attr_accessible :beer_club_id, :user_id, :confirmed, :beer_club, :user
  belongs_to :beer_club
  belongs_to :user
end
