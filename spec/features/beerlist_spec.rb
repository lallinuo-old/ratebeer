require 'spec_helper'

describe "Beerlist page" do
  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(:allow_localhost => true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, :name => "Koff")
    @brewery2 = FactoryGirl.create(:brewery, :name => "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, :name => "Ayinger")
    @style1 = Style.create :style=>"Lager"
    @style2 = Style.create :style=>"Rauchbier"
    @style3 = Style.create :style=>"Weizen"
    @beer1 = FactoryGirl.create(:beer, :name => "Nikolai", :brewery => @brewery1, :style => @style1)
    @beer2 = FactoryGirl.create(:beer, :name => "Fastenbier", :brewery => @brewery2, :style => @style2)
    @beer3 = FactoryGirl.create(:beer, :name => "Lechte Weisse", :brewery => @brewery3, :style => @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows a known beer", :js => true do

    visit beers_path
    find('table').find('tr:nth-child(2)')

    expect(page).to have_content "Nikolai"
  end

  it "has beers sorted by names by default", :js=>true do
    visit beers_path

    find('table').find('tr:nth-child(2)').should have_content('Fastenbier')
    find('table').find('tr:nth-child(3)').should have_content('Lechte Weisse')
    find('table').find('tr:nth-child(4)').should have_content('Nikolai')


  end

  it "sorts list by style if style is clicked", :js=>true do
    visit beers_path
    click_link "style"
    find('table').find('tr:nth-child(2)').should have_content('Lager')
    find('table').find('tr:nth-child(3)').should have_content('Rauchbier')
    find('table').find('tr:nth-child(4)').should have_content('Weizen')
  end

  it "sorts list by breweries if brewery is clicked", :js=>true do
    visit beers_path
    click_link "brewery"
    find('table').find('tr:nth-child(2)').should have_content('Ayinger')
    find('table').find('tr:nth-child(3)').should have_content('Koff')
    find('table').find('tr:nth-child(4)').should have_content('Schlenkerla')
  end
end