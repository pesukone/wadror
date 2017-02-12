require 'rails_helper'

describe "Beer" do
    it "is saved with a valid name" do
    	visit new_beer_path
	fill_in('beer[name]', with:'kalja')
	select('Lager', from:'beer[style]')

	expect{
	    click_button('Create Beer')
	}.to change{Beer.count}.by(1)
    end

    it "is not saved with an invalid name" do
        visit new_beer_path
	select('Lager', from:'beer[style]')

	expect{
	    click_button('Create Beer')
	}.to_not change{Beer.count}
    end
end