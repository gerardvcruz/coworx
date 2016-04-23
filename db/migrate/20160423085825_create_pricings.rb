class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.integer :client_id
      t.integer :space_id
      t.string :name
      t.decimal :price
      t.string :slug

      t.timestamps null: false
    end
    add_index :pricings, :slug, unique: true
  end
end
