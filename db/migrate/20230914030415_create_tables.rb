class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables, id: :uuid do |t|
      t.string :code, null: false
      t.references :restaurant, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :tables, [:code, :restaurant_id], unique: true
  end
end
