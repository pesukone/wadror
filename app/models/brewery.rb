class Brewery < ApplicationRecord
	include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	scope :active, -> { where active:true }
	scope :retired, -> { where active:[nil,false] }

	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1042,
					 only_integer: true }
	validate :year_cannot_be_in_future

	def year_cannot_be_in_future
		if year > Time.now.year
			errors.add(:year, "can't be in the future")
		end
	end

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def restart
		self.year = 2017
		puts "changed year to #{year}"
	end

	def to_s
		name
	end

	def self.top(n)
		sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
		sorted_by_rating_in_desc_order[0, n]
	end
end
