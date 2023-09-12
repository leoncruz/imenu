class AddNameToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :name, :string, null: false

    add_index :restaurants, :name
  end
end
