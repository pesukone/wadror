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

end

