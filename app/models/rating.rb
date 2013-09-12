class Rating < ActiveRecord::Base
  attr_accessible :score, :beer_id

  belongs_to :beer
  belongs_to :user

  def to_s
    "#{beer.name} #{score}"
  end
end