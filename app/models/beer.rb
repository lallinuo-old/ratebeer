class Beer < ActiveRecord::Base
  include RatingAverage

  attr_accessible :brewery_id, :name, :style, :style_id
  validates_length_of :name, :minimum => 1
  validates_length_of :style, :minimum => 1
  belongs_to :brewery
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :user
  belongs_to :style




  def to_s
    return name+", "+brewery.name
  end
end
