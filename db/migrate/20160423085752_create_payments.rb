class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :client_id
      t.integer :space_id
      t.integer :user_id
      t.decimal :amount
      t.datetime :paid_at
      t.integer :invoice_id

      t.timestamps null: false
    end
  end
end
