class AddInfoToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :info, :json
  end
end
