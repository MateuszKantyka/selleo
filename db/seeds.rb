require 'faker'

50.times do
  Product.create!(name: Faker::Pokemon.unique.name)
end

10.times do
  Customer.create!(first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               city: Faker::Address.city,
               postcode: Faker::Address.postcode,
               street_address: Faker::Address.street_address)
end

5.times do
  Order.create!(customer_id: Faker::Number.between(1, 10),
                product_id: Faker::Number.between(1, 50),
                created_at: Faker::Date.backward(3),
                deadline: Faker::Date.forward(14),
                done: Faker::Boolean.boolean)
end
