require 'rails_helper'

RSpec.describe Beer, type: :model do
    it "is saved with a name and style" do
    	style = Style.create style:"kokeellinen", description:"ei testattu"
    	beer = Beer.create name:"testikalja", style: style

	expect(beer).to be_valid
	expect(Beer.count).to eq(1)
    end

    it "is not saved without a name" do
        style = Style.create style:"tuntematon", description:"ei ole"
    	beer = Beer.create style: style

	expect(beer).to_not be_valid
	expect(Beer.count).to eq(0)
    end

    it "is not saved without a style" do
    	beer = Beer.create name:"mauton"

	expect(beer).to_not be_valid
	expect(Beer.count).to eq(0)
    end
end
