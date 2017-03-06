require 'rails_helper'

describe "Beerlist page" do
  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name:"Koff")
    @brewery2 = FactoryGirl.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name:"Ayinger")
    @style1 = Style.create name:"Lager"
    @style2 = Style.create name:"Rauchbier"
    @style3 = Style.create name:"Weizen"
    @beer1 = FactoryGirl.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryGirl.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryGirl.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

  it "orders beers by name by default", js:true do
    visit beerlist_path
    expect(find('table').find('tr:nth-child(2)')).to have_content @beer2.name
    expect(find('table').find('tr:nth-child(3)')).to have_content @beer3.name
    expect(find('table').find('tr:nth-child(4)')).to have_content @beer1.name
  end

  it "can order beers by style", js:true do
    visit beerlist_path
    click_link('Style')

    expect(find('table').find('tr:nth-child(2)')).to have_content @style1.name
    expect(find('table').find('tr:nth-child(3)')).to have_content @style2.name
    expect(find('table').find('tr:nth-child(4)')).to have_content @style3.name
  end

  it "can order beers by brewery", js:true do
    visit beerlist_path
    click_link('Brewery')

    expect(find('table').find('tr:nth-child(2)')).to have_content @brewery3.name
    expect(find('table').find('tr:nth-child(3)')).to have_content @brewery1.name
    expect(find('table').find('tr:nth-child(4)')).to have_content @brewery2.name
  end
end
