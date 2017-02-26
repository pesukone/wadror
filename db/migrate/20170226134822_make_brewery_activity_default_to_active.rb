class MakeBreweryActivityDefaultToActive < ActiveRecord::Migration[5.0]
  def change
    change_column_default :breweries, :active, true
  end
end
