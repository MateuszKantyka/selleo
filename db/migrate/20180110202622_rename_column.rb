class RenameColumn < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :orders, :date, :deadline
  end
end
