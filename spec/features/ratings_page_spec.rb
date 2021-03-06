require 'rails_helper'

include Helpers

describe "Rating" do
    let!(:brewery) { FactoryGirl.create(:brewery, name:"Koff") }
    let!(:beer1) { FactoryGirl.create(:beer, name:"iso 3", brewery:brewery) }
    let!(:beer2) { FactoryGirl.create(:beer, name:"Karhu", brewery:brewery) }
    let!(:user) { FactoryGirl.create(:user) }

    before :each do
    	sign_in(name:"Pekka", password:"Foobar1")
    end

    it "when given, is registered to the beer and user who is signed in" do
    	visit new_rating_path
	select('iso 3', from:'rating[beer_id]')
	fill_in('rating[score]', with:'15')

	expect{
	    click_button "Create Rating"
	}.to change{Rating.count}.from(0).to(1)

	expect(user.ratings.count).to eq(1)
	expect(beer1.ratings.count).to eq(1)
	expect(beer1.average_rating).to eq(15.0)
    end
end

describe "Ratings" do
    it "and their amount are shown on the ratings page" do
        user = FactoryGirl.create(:user)
	create_beers_with_ratings(user, 12, 32, 21, 40)

    	visit ratings_path

	expect(page).to have_content("Number of ratings : #{Rating.count}")
	Rating.all.each do |rating|
	    expect(page).to have_content("#{rating.beer.name} #{rating.score}")
	end
    end
end

def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, user:user, score:score, beer:beer)
    beer
end

def create_beers_with_ratings(user, *scores)
    scores.each do |score|
    	create_beer_with_rating(user, score)
    end
end
