class Beer < ActiveRecord::Base
  include RatingAverage
  attr_accessible :name, :style, :brewery_id

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  # ...

  def average_rating
    sum = 0.0
    i = 0.0
    ratings.each{|rating|
      sum+=rating.score
      i+=1
    }
    average = sum/i

    return "Beer has "+ratings.length.to_s+" rating".pluralize(ratings.length)+", average "+average.to_s
  end

  def to_s
    return name+", "+brewery.name
  end
end
