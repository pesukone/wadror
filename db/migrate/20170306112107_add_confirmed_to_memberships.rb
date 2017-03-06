class AddConfirmedToMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :confirmed, :boolean, null: false, default: false
  end
end
