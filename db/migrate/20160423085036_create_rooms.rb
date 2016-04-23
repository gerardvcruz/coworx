class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :client_id
      t.integer :space_id
      t.json :info
      t.json :settings
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :rooms, :slug, unique: true
  end
end
