class Beer < ActiveRecord::Base
  include RatingAverage

  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :user


  def to_s
    return name+", "+brewery.name
  end
end
