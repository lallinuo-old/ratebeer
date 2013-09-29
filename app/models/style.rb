class Style < ActiveRecord::Base
  attr_accessible :desc, :style
  has_many :beers

  def to_s
    style
  end
end
