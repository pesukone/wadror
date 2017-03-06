class Rating < ApplicationRecord
	belongs_to :beer, optional: true, touch: true
	belongs_to :user	# rating kuuluu myös käyttäjään

	validates :score, numericality: { greater_than_or_equal_to: 1,
					 less_than_or_equal_to: 50,
					 only_integer: true }
	
	scope :recent, -> { order(updated_at: :desc).limit(5) }

	def to_s
		"#{beer.name} #{score}"
	end
end
