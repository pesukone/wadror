module RatingAverage
    extend ActiveSupport::Concern

    def average_rating
    	return 0 if ratings.count == 0
        ratings.average(:score)
    end
end
