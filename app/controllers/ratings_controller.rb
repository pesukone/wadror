class RatingsController < ApplicationController
    def index
    	@ratings = Rating.all
	UpdateRatings.new.perform if Rails.cache.read("beer top 3") == nil
	@top_beers = Rails.cache.read "beer top 3"
	@top_breweries = Rails.cache.read "brewery top 3"
	@top_users = Rails.cache.read "user top 3"
	@top_styles = Rails.cache.read "style top 3"
	@recent_ratings = Rating.recent.compact
    end

    def new
        @rating = Rating.new
        @beers = Beer.all
    end

    def create
        @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
	
	if current_user.nil?
	    redirect_to signin_path, notice:'you should be signed in'
	elsif current_user.ratings << @rating
	    redirect_to user_path current_user
	else
	    @beers = Beer.all
	    render :new
	end
    end

    def destroy
        rating = Rating.find(params[:id])
        rating.delete if current_user == rating.user
        redirect_back(fallback_location: root_path)
    end
end
