class RatingsController < ApplicationController
    def index
    	@ratings = Rating.all
	@top_beers = Beer.top(3).compact
	@top_breweries = Brewery.top(3).compact
	@top_users = User.top(3).compact
	@top_styles = Style.top(3).compact
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
