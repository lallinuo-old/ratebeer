class Style < ActiveRecord::Base
  include RatingAverage
  has_many :ratings, :through => :beers

  attr_accessible :desc, :style
  has_many :beers


  def to_s
    style
  end


  def self.top_styles
    sorted_by_rating_in_desc_order =Style.all.sort_by{ |b| -b.average_rating }.first(3)

  end
end
