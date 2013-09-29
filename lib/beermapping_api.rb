class BeermappingAPI
  def self.places_in(city)
    Place # varmistaa, että luokan koodi on ladattu
    city = city.downcase
    Rails.cache.write city, fetch_places_in(city) if not Rails.cache.exist? city

    Rails.cache.read city
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end
  def self.getscores(id)
    url = "http://beermapping.com/webservice/locscore/#{key}/"
    response = HTTParty.get "#{url}#{id.gsub(' ', '%20')}"
    score = response.parsed_response["bmp_locations"]["location"]
    score = [score] if score.is_a?(Hash)
    score.inject([]) do | set, place |
      set << place
    end
    return score
  end
  def self.key
    "96ce1942872335547853a0bb3b0c24db"
  end
end