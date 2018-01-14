require 'rails_helper'

RSpec.describe CustomersController do
  describe '#index' do
    it 'render index page' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    context 'when params are valid' do
      it 'create a new customers' do
        params = { customer: { first_name: 'James',
                               last_name: 'William',
                               city: 'London',
                               postcode: 'W5 5YZ',
                               street_address: '50 Water Street' } }

        post(:create, params: params)

        expect(Customer.first.first_name).to eq 'James'
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(customers_path)
      end
    end

    context 'when params are not valid' do
      it 'refresh new customer view' do
        params =  { customer: { first_name: '' } }

        post(:create, params: params)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    context 'when params are valid' do
      it 'update customer and redirect to customers' do
        customer = create(:customer, first_name: 'James')
        params = { id: customer.id, customer: { first_name: 'John' } }

        patch(:update, params: params)
        customer.reload

        expect(customer.first_name).to eq 'John'
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(customers_path)
      end
    end

    context 'when params are not valid' do
      it 'refresh edit customer view' do
        customer = create(:customer, first_name: 'James')
        params = { id: customer.id, customer: { first_name: '' } }

        patch(:update, params: params)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    context 'when customer is provided' do
      it 'delete customer form database and refresh index page' do
        customer = create(:customer)

        delete(:destroy, params: { id: customer.id })

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(customers_path)
        expect(Customer.first).to eq nil
      end
    end
  end
end
