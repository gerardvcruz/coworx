class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.json :info
      t.json :settings
      t.string :slug, unique: true

      t.timestamps null: false
    end
  end
end
