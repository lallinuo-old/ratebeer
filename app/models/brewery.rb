class Brewery < ActiveRecord::Base
  include rating_average
  attr_accessible :name, :year
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers
end
