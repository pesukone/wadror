class BeerClub < ApplicationRecord
	has_many :memberships, -> { where confirmed: true }
	has_many :members, -> { distinct }, through: :memberships, source: :user
end
