class ChangeStyleName < ActiveRecord::Migration[5.0]
  def change
    rename_column :styles, :style, :name
  end
end
