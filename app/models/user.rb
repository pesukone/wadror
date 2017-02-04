class User < ApplicationRecord
	include RatingAverage

	validates :username, uniqueness: true,
			     length: { in: 3..30 }

	has_many :ratings 	# käyttäjällä on monta ratingia
	has_many :beers, through: :ratings

	has_many :memberships
	has_many :beer_clubs, -> { distinct }, through: :memberships, source: :beer_club
end

