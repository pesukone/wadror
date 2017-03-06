class User < ApplicationRecord
	include RatingAverage

	validates :name, uniqueness: true,
			     length: { in: 3..30 }, unless: :github?

	has_secure_password validations: false
	validates :password, length: { minimum: 4 }, unless: :github?
	validates :password, format: { with: /\d/, message: "has to include a number" }, unless: :github?
	validates :password, format: { with: /[A-ZÅÄÖ]/, message: "has to include a capital letter" }, unless: :github?

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
		Style.find_by name: ratings.joins(beer: :style).order(score: :desc).group('styles.name').average(:score).first.first
	end

	def favorite_brewery
		return nil if ratings.empty?
		Brewery.find_by name: ratings.joins(beer: :brewery).order(score: :desc).group('breweries.name').average(:score).first.first
	end

	def self.top(n)
		sorted_by_number_of_ratings_in_desc_order = User.all.sort_by{ |u| -(u.ratings.count||0) }
		sorted_by_number_of_ratings_in_desc_order[0, n]
	end
end

