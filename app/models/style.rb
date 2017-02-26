class Style < ApplicationRecord
    has_many :beers

    def to_s
        "#{name}"
    end

    def average_rating
    	beers.joins(:ratings).average(:score)
    end

    def self.top(n)
    	sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.average_rating||0) }
	sorted_by_rating_in_desc_order[0, n]
    end
end
