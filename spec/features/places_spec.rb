require 'rails_helper'

describe "Places" do
    it "if one is returned by the API, it is shown at the page" do
    	allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
	    [ Place.new( name:"Oljenkorsi", id: 1, street:"Jokukatu", zip:12345, city:"kumpula" ) ]
	)

	allow(WeatherApi).to receive(:weather_in)

	visit places_path
	fill_in('city', with: 'kumpula')
	click_button "Search"

	expect(page).to have_content "Oljenkorsi"
    end

    it "if many are returned by the API, they are shown at the page" do
    	allow(BeermappingApi).to receive(:places_in).with("soukka").and_return(
	    [ Place.new( name:"Wilperi", id: 1, street:"Tie Soukassa", zip:67890, city:"soukka" ),
	      Place.new( name:"Ruorimies", id: 2 ) ]
	)

	allow(WeatherApi).to receive(:weather_in)

	visit places_path
	fill_in('city', with: 'soukka')
	click_button "Search"

	expect(page).to have_content "Wilperi"
	expect(page).to have_content "Ruorimies"
    end

    it "if none returned by the API, a message is shown" do
    	allow(BeermappingApi).to receive(:places_in).with("jupperi").and_return([])

	allow(WeatherApi).to receive(:weather_in)

	visit places_path
	fill_in('city', with: 'jupperi')
	click_button "Search"

	expect(page).to have_content "No locations in jupperi"
    end
end
