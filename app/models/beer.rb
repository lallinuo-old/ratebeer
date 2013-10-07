class Beer < ActiveRecord::Base
  include RatingAverage

  attr_accessible :brewery_id, :name, :style, :style_id
  validates_length_of :name, :minimum => 1
  validates_length_of :style, :minimum => 1
  belongs_to :brewery

  has_many :ratings, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :user
  belongs_to :style



  def self.top_beers
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -b.average_rating }.first(3)
  end
  def to_s
    return name+", "+brewery.name
  end
end
