require 'rails_helper'

RSpec.feature 'Product' do
  scenario 'user can create a new product' do
    visit root_path
    click_on 'Products'
    click_on 'New Product'
    fill_in :product_name, with: 'Pikachu'
    click_on 'Create Product'

    expect(page).to have_content 'Product created'
    expect(page).to have_content 'Pikachu'
  end

  scenario 'user can edit a product' do
    create(:product, name: 'Raichu')

    visit root_path
    click_on 'Products'
    click_on 'Edit'
    fill_in :product_name, with: 'Pikachu'
    click_on 'Update Product'

    expect(page).to have_content 'Product updated'
    expect(page).to have_content 'Pikachu'
  end

  scenario 'user can delete a product' do
    create(:product)

    visit root_path
    click_on 'Products'
    click_on 'Delete'

    expect(page).to have_content 'Product deleted'
    expect(page).not_to have_content 'Delete'
  end
end
