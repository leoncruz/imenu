class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items, id: :uuid do |t|
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.decimal :price, null: false
      t.text :description, null: false, defaul: ''

      t.timestamps
    end

    add_index :items, :name, unique: true
    add_index :items, :price
  end
end
