class CreateCustomer < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :postcode
      t.string :street_address
    end
  end
end
