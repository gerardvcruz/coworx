class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.integer :space_id
      t.integer :client_id
      t.datetime :start
      t.datetime :end

      t.timestamps null: false
    end
  end
end
