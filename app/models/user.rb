class User < ApplicationRecord
	include RatingAverage

	has_many :ratings 	# käyttäjällä on monta ratingia
end

class Rating < ApplicationRecord
	belongs_to :beer
	belongs_to :user 	# rating kuuluu myös käyttäjään

	def to_s
		"#{beer.name} #{score}"
	end
end
