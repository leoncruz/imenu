class FixUniqueIndexOnItemName < ActiveRecord::Migration[7.0]
  def up
    remove_index :items, :name

    add_index :items, [:name, :category_id], unique: true
  end

  def down
    remove_index :items, :name

    add_index :items, :name, unique: true
  end
end
