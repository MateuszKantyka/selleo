class CreateOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.references :customer, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
