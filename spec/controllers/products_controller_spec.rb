require 'rails_helper'

RSpec.describe ProductsController do
  describe '#index' do
    it 'render index page' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    context 'when params are valid' do
      it 'create a new products' do
        params = { product: { name: 'Example product name' } }

        post(:create, params: params)

        expect(Product.first.name).to eq 'Example product name'
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end

    context 'when params are not valid' do
      it 'refresh new product view' do
        params = { product: { name: '' } }

        post(:create, params: params)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    context 'when params are valid' do
      it 'update product and redirect to products' do
        product = create(:product, name: 'example name')
        params = { id: product.id, product: { name: 'another example name' } }

        patch(:update, params: params)
        product.reload

        expect(product.name).to eq 'another example name'
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end

    context 'when params are not valid' do
      it 'refresh edit product view' do
        product = create(:product, name: 'example name')
        params = { id: product.id, product: { name: '' } }

        patch(:update, params: params)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    context 'when product is provided' do
      it 'delete product form database and refresh index page' do
        product = create(:product)

        delete(:destroy, params: { id: product.id })

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
        expect(Product.first).to eq nil
      end
    end
  end
end
