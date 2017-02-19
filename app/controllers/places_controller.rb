# Tämä rivi tarvitaan jotta api toimii herokussa ja travisissa
require 'beermapping_api'
require 'weather_api'

class PlacesController < ApplicationController
    def index
    end

    def search
	@places = BeermappingApi.places_in(params[:city])
	@weather = WeatherApi.weather_in(params[:city])
	if @places.empty? 
	    redirect_to places_path, notice: "No locations in #{params[:city]}"
	else
	    session[:city] = @places.first.city.downcase
	    render :index
	end
    end

    def show
        @place = Rails.cache.read(session[:city]).select { |place| place.id == params[:id].to_s }.first
    end
end
