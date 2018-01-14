class AddColumnsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :done, :boolean
    add_column :orders, :created_at, :datetime
  end
end
