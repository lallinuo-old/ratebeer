class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation
  has_secure_password
  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4
  has_many :ratings, :dependent => :destroy
  has_many :memberships
  has_many :beers, :through => :ratings
  has_many :beer_clubs, :through => :memberships



end