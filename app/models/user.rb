class User < ActiveRecord::Base
  include RatingAverage
  attr_accessible :username

  has_many :ratings
end