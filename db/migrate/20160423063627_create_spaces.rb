class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.integer :client_id
      t.json :settings
      t.json :info
      t.string :name
      t.string :slug, unique: true

      t.timestamps null: false
    end
  end
end
