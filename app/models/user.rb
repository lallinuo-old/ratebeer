class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation
  has_secure_password
  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4
  has_many :ratings, :dependent => :destroy
  validate :test, on: "create"
  has_many :memberships
  has_many :beers, :through => :ratings
  has_many :beer_clubs, :through => :memberships

  def test
    if password  =~ /^[a-zA-Z]+$/
      errors.add :password, "Password must contain numbers/symbols"
    end
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style

    return nil if ratings.empty?
    ratedStyles = []
    ratings.each{ |r|
       if !ratedStyles.include?(r.beer.style)
         ratedStyles << r.beer.style
       end
    }
    highestRatedAvg = 0
    highestRated = nil
  ratedStyles.each{|s|
    sum = 0
    i = 0
    ratings.each{    |r|
      if r.beer.style == s
        sum+=r.score
        i+=1
      end
    }
    avg = sum/i
    if avg>highestRatedAvg
      highestRated = s
      highestRatedAvg = avg
    end
  }
    #highestRated
    return highestRated
  end

  def favorite_brewery
    rated_breweries = []
    ratings.each{|r|

      if !rated_breweries.include? r.beer.brewery
          rated_breweries << r.beer.brewery
      end
    }
    highestRatedAvg=0
    highestRated = nil
    rated_breweries.each{ |b|
      sum = 0
      i = 0
       ratings.each{|z|
          if z.beer.brewery == b
            i+=1;
            sum+=z.score
          end
       }
      avg=sum/i
      if avg>highestRatedAvg
        highestRatedAvg=avg
        highestRated = b
      end
    }
    highestRated
  end



 end
