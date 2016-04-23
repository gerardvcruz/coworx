class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :client_id
      t.integer :space_id
      t.integer :user_id
      t.decimal :amount
      t.datetime :paid_at

      t.timestamps null: false
    end
  end
end
