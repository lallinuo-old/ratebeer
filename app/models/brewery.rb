class Brewery < ActiveRecord::Base
  include RatingAverage
  attr_accessible :name, :year
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers
  validates :name, presence: true
  validates_numericality_of :year, :greater_than => 1041, :less_than => :getYear

def getYear
  return Time.now.year
end


end
