module RatingAverage

  def average_rating
    sum = 0.0
    i = 0.0
    ratings.each{|rating|
      sum+=rating.score
      i+=1
    }
    if sum==0
      return 0
    end
    average = sum/i
    return average


  end


end