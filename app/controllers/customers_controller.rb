class CustomersController < ApplicationController
  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result(distinct: true)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path
      flash[:success] = 'Customer created'
    else
      flash.now[:danger] = 'Correct the field'
      render 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash[:success] = 'Customer updated'
      redirect_to customers_path
    else
      flash.now[:danger] = 'Correct the field'
      render 'edit'
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    flash[:success] = 'Customer deleted'
    redirect_to customers_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :city,
                                     :postcode, :street_address)
  end
end
