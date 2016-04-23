class AddDueAtToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :due_at, :datetime
  end
end
