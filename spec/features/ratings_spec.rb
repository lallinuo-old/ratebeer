require 'spec_helper'

describe "Rating" do
  include OwnTestHelper

  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
  let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in 'Pekka', 'foobar1'
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "is showing up on users page" do
    rating = FactoryGirl.create :rating, :beer => beer1, :user => user, :score => 44
    visit "/users/1/"
    expect(page).to have_content "44"

  end
  it "is removed from database if user removes it" do
    rating = FactoryGirl.create :rating, :beer => beer1, :user => user, :score => 44
    expect(user.ratings.count).to eq(1)
    visit "/users/1/"
    expect(page).to have_content "44"
    click_link "delete"
    expect(user.ratings.count).to eq(0)
  end

  it "is showing up on Ratings page" do
    FactoryGirl.create :rating, :score => 44, :beer => beer1, :user => user
    visit ratings_path
    expect(page).to have_content "44"

  end

end