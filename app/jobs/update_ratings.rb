class UpdateRatings
  include SuckerPunch::Job

  def perform
    Rails.cache.write("beer top 3", Beer.top(3).compact)
    Rails.cache.write("brewery top 3", Brewery.top(3).compact)
    Rails.cache.write("style top 3", Style.top(3).compact)
    Rails.cache.write("user top 3", User.top(3).compact)
    UpdateRatings.perform_in(5.minutes)
  end
end
