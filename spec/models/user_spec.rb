require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new :username => "Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a proper password" do
    user = User.create :username => "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating1)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
  it "doesn't save user with too short password" do
    user = User.create :username=>"M", :password =>"moi", :password_confirmation => "moi"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "doesn't save user with password only containing letters" do
    user = User.create :username=>"Mm", :password =>"moimoimoi", :password_confirmation => "moimoimoi"
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating 10, user

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings 10, 20, 15, 7, 9, user
      best = create_beer_with_rating 25, user

      expect(user.favorite_beer).to eq(best)
    end

    def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating score, user
    end
    end


  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user)}
    it "has method for determining one" do
      user.should respond_to :favorite_style
    end
    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end
    it "is the only rated if only one rating" do
      beer = create_beer_with_rating 10, user

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest rating if several rated" do
      style1 = FactoryGirl.create(:style, :style =>"tyyli1")
      style2 = FactoryGirl.create(:style, :style =>"tyyli2")
      style3 = FactoryGirl.create(:style, :style =>"tyyli3")

      create_beer_with_style(style1, 21, user)


      create_beer_with_style(style2, 24, user)
      create_beer_with_style(style2, 28, user)

      create_beer_with_style(style3, 23, user)

      expect(Rating.count).to eq(4)
      expect(user.favorite_style.to_s).to eq(style2.to_s)
    end
  end


  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user)}
    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without breweries doesnt have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the one with the highest rating if several breweries rated" do
      brewery = FactoryGirl.create(:brewery, :name => "top")
      brewery1 = FactoryGirl.create(:brewery, :name => "top1")
      brewery2 = FactoryGirl.create(:brewery, :name => "top2")
      create_beer_with_rating_and_brewery(20,user,brewery)
      create_beer_with_rating_and_brewery(24,user,brewery1)
      create_beer_with_rating_and_brewery(25,user,brewery2)
      create_beer_with_rating_and_brewery(1,user,brewery2)

      expect(Beer.count).to eq(4)
      expect(Brewery.count).to eq(3)
      expect(user.favorite_brewery).to eq(brewery1)



    end


  end


  def create_beer_with_style(style,score,user)
    beer = FactoryGirl.create(:beer, :style => style)
    FactoryGirl.create(:rating,:beer => beer, :score =>score, :user => user)


  end
  def create_beer_with_rating(score,  user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
    beer
  end
  def create_beer_with_rating_and_brewery(score,  user,brewery)
    beer = FactoryGirl.create(:beer, :brewery => brewery)
    FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
    beer
  end

end