class Brewery < ActiveRecord::Base
  include RatingAverage

  attr_accessible :name, :year, :active

  scope :active, where(:active => true)
  scope :retired, where(:active => [nil, false])

  has_many :beers
  has_many :ratings, :through => :beers

  def getYear
    return Time.now.year
  end

  def self.top_breweries
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -b.average_rating }.first(3)

  end
end