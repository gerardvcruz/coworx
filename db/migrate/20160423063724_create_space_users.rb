class CreateSpaceUsers < ActiveRecord::Migration
  def change
    create_table :space_users do |t|
      t.integer :space_id
      t.integer :user_id
      t.json :settings

      t.timestamps null: false
    end
  end
end
