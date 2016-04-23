class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :client_id
      t.integer :space_id
      t.integer :user_id
      t.integer :pricing_id

      t.timestamps null: false
    end
  end
end
