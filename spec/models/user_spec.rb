require 'rails_helper'

RSpec.describe User, type: :model do
    it "has the username set correctly" do
        user = User.new name:"Pekka"

	expect(user.name).to eq("Pekka")
    end

    it "is not saved without a password" do
    	user = User.create name:"Pekka"

	expect(user).not_to be_valid
	expect(User.count).to eq(0)
    end

    describe "with a proper password" do
    	let(:user){ FactoryGirl.create(:user) }

    	it "is saved" do
	    expect(user).to be_valid
	    expect(User.count).to eq(1)
        end

    	it "and with two ratings has the correct average rating" do
	    user.ratings << FactoryGirl.build(:rating)
	    user.ratings << FactoryGirl.build(:rating2)

	    expect(user.ratings.count).to eq(2)
	    expect(user.average_rating).to eq(15.0)
	end
    end

    it "is not saved with a too short password" do
    	user = User.create name:"Pekka", password:"asd", password_confirmation:"asd"

	expect(user).to_not be_valid
	expect(User.count).to eq(0)
    end

    it "is not saved with a password, which has no numbers" do
        user = User.create name:"Pekka", password:"Salasana", password_confirmation:"Salasana"

	expect(user).to_not be_valid
	expect(User.count).to eq(0)
    end

    describe "favorite beer" do
    	let(:user) { FactoryGirl.create(:user) }

	it "has method for determining one" do
	    expect(user).to respond_to(:favorite_beer)
	end

	it "without ratings does not have one" do
	    expect(user.favorite_beer).to eq(nil)
	end

	it "is the only rated if only one rating" do
	    beer = create_beer_with_rating(user, 10)

	    expect(user.favorite_beer).to eq(beer)
	end

	it "is the one with the highest rating if several rated" do
	    create_beers_with_ratings(user, 10, 20, 15, 7, 9)
	    best = create_beer_with_rating(user, 25)

	    expect(user.favorite_beer).to eq(best)
	end
    end

    describe "favorite style" do
    	let(:user){ FactoryGirl.create(:user) }

	it "has method for determining one" do
	    expect(user).to respond_to(:favorite_style)
	end

	it "without ratings does not have one" do
	    expect(user.favorite_style).to eq(nil)
	end

	it "is the only rated beers style if only one rating" do
	    beer = create_beer_with_rating(user, 20)

	    expect(user.favorite_style).to eq(beer.style)
	end

	it "has the highest average rating" do
	    style1 = FactoryGirl.create(:style, name:"IPA")
	    style2 = FactoryGirl.create(:style, name:"Pale ale")
	    create_beers_with_ratings_and_style(style1, user, 10, 20, 30)
	    create_beers_with_ratings_and_style(style2, user, 20, 30, 40)

	    expect(user.favorite_style).to eq(style2)
	end
    end

    describe "favorite brewery" do
    	let(:user){ FactoryGirl.create(:user) }

	it "has method for determining one" do
	    expect(user).to respond_to(:favorite_brewery)
	end

	it "without ratings does not have one" do
	    expect(user.favorite_brewery).to eq(nil)
	end

	it "is the only rated beers brewery if only one rating" do
	    brewery = FactoryGirl.create(:brewery)
	    brewery2 = FactoryGirl.create(:brewery, name:"named", year:1980)
	    brewery3 = FactoryGirl.create(:brewery, name:"third", year:2000)

	    create_beers_with_ratings_and_brewery(brewery, user, 10, 20, 30)
	    create_beers_with_ratings_and_brewery(brewery2, user, 20, 30, 40)
	    create_beers_with_ratings_and_brewery(brewery3, user, 10)

	    expect(user.favorite_brewery).to eq(brewery2)
	end
    end
end

def create_beers_with_ratings(user, *scores)
    scores.each do |score|
    	create_beer_with_rating user, score
    end
end

def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
end

def create_beer_with_rating_and_style(style, user, score)
    beer = FactoryGirl.create(:beer, style:style)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
end

def create_beers_with_ratings_and_style(style, user, *scores)
    scores.each do |score|
    	create_beer_with_rating_and_style style, user, score
    end
end

def create_beer_with_rating_and_brewery(brewery, user, score)
    beer = FactoryGirl.create(:beer, brewery:brewery)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
end

def create_beers_with_ratings_and_brewery(brewery, user, *scores)
    scores.each do |score|
    	create_beer_with_rating_and_brewery brewery, user, score
    end
end
