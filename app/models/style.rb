class Style < ApplicationRecord
    has_many :beers

    def to_s
        "#{style}"
    end
end
