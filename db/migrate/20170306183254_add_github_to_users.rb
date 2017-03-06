class AddGithubToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :github, :boolean, null: false, default: false
  end
end
