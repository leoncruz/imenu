class FixUniqueIndexOnCategoryName < ActiveRecord::Migration[7.0]
  def up
    remove_index :categories, name: :index_categories_on_name

    add_index :categories, [:name, :menu_id], unique: true
  end

  def down
    remove_index :categories, :name

    add_index :categories, :name, unique: true
  end
end
