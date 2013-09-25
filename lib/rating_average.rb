module RatingAverage

  def average_rating
    sum = 0.0
    i = 0.0
    ratings.each{|rating|
      sum+=rating.score
      i+=1
    }
    average = sum/i

return average;
  end


end