class User < ApplicationRecord
	include RatingAverage

	validates :username, uniqueness: true,
			     length: { in: 3..30 }

	has_secure_password
	validates :password, length: { minimum: 4 }
	validates :password, format: { with: /\d/, message: "has to include a number" }
	validates :password, format: { with: /[A-ZÅÄÖ]/, message: "has to include a capital letter" }

	has_many :ratings, dependent: :destroy 
	has_many :beers, through: :ratings

	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, -> { distinct }, through: :memberships, source: :beer_club

	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
	end
	
	def favorite_style
		return nil if ratings.empty?
		Style.find_by style: ratings.joins(beer: :style).order(score: :desc).group(:style).average(:score).first.first
	end

	def favorite_brewery
		return nil if ratings.empty?
		Brewery.find_by name: ratings.joins(beer: :brewery).order(score: :desc).group('breweries.name').average(:score).first.first
	end
end

