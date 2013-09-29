require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return( [  Place.new(:name => "Oljenkorsi") ] )

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "contains all places if more than one place" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return( [  Place.new(:name => "Oljenkorsi"), Place.new(:name =>"King kebab") ] )
    visit places_path
    fill_in("city", :with => "kumpula")
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "King kebab"
  end
  it "contains notice if empty table" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return( [] )
    visit places_path
    fill_in("city", :with=>"kumpula")
    click_button "Search"
    expect(page).to have_content "No locations in kumpula city"
  end


end