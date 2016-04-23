class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :client_id
      t.integer :space_id
      t.integer :room_id
      t.datetime :start
      t.datetime :end
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
