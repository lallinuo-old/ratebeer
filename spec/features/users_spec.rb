require 'spec_helper'

describe "User" do
  include OwnTestHelper

  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can sign in with right credentials" do
      sign_in 'Pekka', 'foobar1'

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to sign in form if wrong credentials given" do
      sign_in 'Pekka', 'wrong'

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end
  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', :with => 'Brian')
    fill_in('user_password', :with => 'secret55')
    fill_in('user_password_confirmation', :with => 'secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "can add beer to database" do
    FactoryGirl.create :brewery
    sign_in "Pekka", "foobar1"
    visit new_beer_path
    select 'anonymous', :from => 'Brewery'
    select 'Weizen', :from => 'Style'

    fill_in 'Name', :with => 'parina'
    click_button("Create Beer")

    expect(Beer.count).to eq(1)
  end

  it "has favorite style and brewery" do
    user = User.first
    brewery = FactoryGirl.create :brewery, :name =>"panimo"
    beer = FactoryGirl.create :beer, :style => "Lager", :brewery => brewery
    FactoryGirl.create :rating, :score => 50, :beer => beer, :user => user
    visit "/users/1"
    expect(page).to have_content "Favorite beer style: Lager"
    expect(page).to have_content "Favorite brewery: panimo"

  end
end