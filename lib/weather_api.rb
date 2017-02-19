class WeatherApi
    def self.weather_in(city)
    	city = city.downcase
	get_weather_in(city)
    end

    private

    def self.get_weather_in(city)
        url = 'https://api.apixu.com/v1/current.json?key=' + ENV['APIXU'] + '&q='

	response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
	ActiveSupport::JSON.decode(response.body)
    end
end
