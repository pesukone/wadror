require 'rails_helper'

include Helpers

describe "User" do
    let!(:user){ FactoryGirl.create(:user) }
    
    describe "who has signed up" do
    	it "can signin with right credentials" do
	    sign_in(username:"Pekka", password:"Foobar1")

	    expect(page).to have_content 'Welcome back!'
	    expect(page).to have_content 'Pekka'
	end

	it "is redirected back to signin form if wrong cedentials given" do
	    sign_in(username:"Pekka", password:"wrong")

	    expect(current_path).to eq(signin_path)
	    expect(page).to have_content 'Username and/or password mismatch'
	end
    end
    
    it "when signed up with good credentials, is added to the system" do
    	visit signup_path
	fill_in('user_username', with:'Brian')
	fill_in('user_password', with:'Secret55')
	fill_in('user_password_confirmation', with:'Secret55')

	expect{
	    click_button('Create User')
	}.to change{User.count}.by(1)
    end
    
    it "has a link to favorite beer" do
	create_beer_with_rating(user, 13)
    	visit user_path user

	expect(page).to have_content("favorite beer: #{user.favorite_beer.brewery} #{user.favorite_beer.name}")

	click_link("#{user.favorite_beer.brewery} #{user.favorite_beer.name}")

	expect(page).to have_current_path(beer_path user.favorite_beer)
    end

    it "has a link to favorite brewery" do
	create_beer_with_rating(user, 13)
	visit user_path user

	expect(page).to have_content("favorite brewery: #{user.favorite_brewery}")

	click_link("#{user.favorite_brewery}")

	expect(page).to have_current_path(brewery_path user.favorite_brewery)
    end
end

describe "Users" do
    let!(:user){ FactoryGirl.create(:user) }

    before :each do
    	create_beers_with_ratings(user, 12, 23, 21, 4)
    end

    it "page shows the ratings made by the user" do
	toinen = FactoryGirl.create(:user, username:"Jonne")
	create_beers_with_ratings(toinen, 23, 21)

    	visit user_path user

	expect(page).to have_content("ratings")
	user.ratings.each do |rating|
	    expect(page).to have_content("#{rating.beer.name} #{rating.score}")
	end
    end

    it "rating is deleted from database when delete button is pressed" do
        sign_in(username:"Pekka", password:"Foobar1")
    	visit user_path user

	expect{
	    first(:link, 'delete').click
	}.to change{user.ratings.count}.by(-1)
    end
end
