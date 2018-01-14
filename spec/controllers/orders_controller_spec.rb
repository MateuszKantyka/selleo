require 'rails_helper'

RSpec.describe OrdersController do
  describe '#index' do
    it 'render index page' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    context 'when params are valid' do
      it 'create a new orders' do
        product = create(:product)
        customer = create(:customer)
        params = { order: { product_id: product.id,
                            customer_id: customer.id,
                            created_at: Date.new(2018, 1, 1),
                            deadline: Date.new(2018, 1, 14) } }

        post(:create, params: params)

        expect(Order.first.deadline.to_s).to eq '2018-01-14'
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(orders_path)
      end
    end

    context 'when params are not valid' do
      it 'refresh new order view' do
        params = { order: { deadline: '' } }

        post(:create, params: params)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    context 'when params are valid' do
      it 'update order and redirect to orders' do
        product = create(:product)
        customer = create(:customer)
        order = create(:order, product: product, customer: customer,
                               deadline: '2018-01-14')
        params = { id: order.id, order: { deadline: Date.new(2018, 1, 15) } }

        patch(:update, params: params)
        order.reload

        expect(order.deadline.to_s).to eq '2018-01-15'
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(orders_path)
      end
    end

    context 'when params are not valid' do
      it 'refresh edit order view' do
        product = create(:product)
        customer = create(:customer)
        order = create(:order, product: product, customer: customer,
                               deadline: '2018-01-14')
        params = { id: order.id, order: { deadline: '' } }

        patch(:update, params: params)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    context 'when order is provided' do
      it 'delete order form database and refresh index page' do
        product = create(:product)
        customer = create(:customer)
        order = create(:order, product: product, customer: customer)

        delete(:destroy, params: { id: order.id })

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(orders_path)
        expect(Order.first).to eq nil
      end
    end
  end

  describe '#change_order_status' do
    context 'when user click change status button' do
      context 'when order status is false' do
        it 'change order status to true' do
          product = create(:product)
          customer = create(:customer)
          order = create(:order, product: product, customer: customer,
                                 done: false)

          post(:change_order_status, params: { id: order.id })
          order.reload

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(orders_path)
          expect(order.done).to eq true
        end
      end

      context 'when order status is true' do
        it 'change order status to false' do
          product = create(:product)
          customer = create(:customer)
          order = create(:order, product: product, customer: customer,
                                 done: true)

          post(:change_order_status, params: { id: order.id })
          order.reload

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(orders_path)
          expect(order.done).to eq false
        end
      end
    end
  end
end
