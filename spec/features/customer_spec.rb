require 'rails_helper'

RSpec.feature 'Customer' do
  scenario 'user can create a new customer' do
    visit root_path
    click_on 'Customers'
    click_on 'New Customer'
    fill_in :customer_first_name, with: 'James'
    fill_in :customer_last_name, with: 'William'
    fill_in :customer_city, with: 'London'
    fill_in :customer_postcode, with: 'W5 5YZ'
    fill_in :customer_street_address, with: '50 Water Street'
    click_on 'Create Customer'

    expect(page).to have_content 'Customer created'
    expect(page).to have_content 'James'
  end

  scenario 'user can edit a customer' do
    create(:customer, first_name: 'Gabriell')

    visit root_path
    click_on 'Customers'
    click_on 'Edit'
    fill_in :customer_first_name, with: 'James'
    click_on 'Update Customer'

    expect(page).to have_content 'Customer updated'
    expect(page).to have_content 'James'
  end

  scenario 'user can delete a customer' do
    create(:customer)

    visit root_path
    click_on 'Customers'
    click_on 'Delete'

    expect(page).to have_content 'Customer deleted'
    expect(page).not_to have_content 'Delete'
  end
end
