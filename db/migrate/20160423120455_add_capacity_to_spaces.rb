class AddCapacityToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :capacity, :integer, default: 0
  end
end
