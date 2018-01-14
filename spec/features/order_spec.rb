require 'rails_helper'

RSpec.feature 'Order' do
  scenario 'user can create a new order' do
    create(:customer)
    create(:product)

    visit root_path
    click_on 'Orders'
    click_on 'New order'
    click_on 'Create Order'
    expect(page).to have_content 'Order successfully created'
    expect(page).to have_content 'Delete'
  end

  scenario 'user can edit a order' do
    create(:order, customer: create(:customer),
                   product: create(:product))
    create(:product, name: 'Raichu')

    visit root_path
    click_on 'Orders'
    click_on 'Edit'
    select('Raichu', from: 'order_product_id')
    click_on 'Update Order'

    expect(page).to have_content 'Order updated'
    expect(page).to have_content 'Raichu'
  end

  scenario 'user can delete a order' do
    create(:order, customer: create(:customer),
                   product: create(:product))

    visit root_path
    click_on 'Orders'
    click_on 'Delete'

    expect(page).to have_content 'Order deleted'
    expect(page).not_to have_content 'Delete'
  end
end
