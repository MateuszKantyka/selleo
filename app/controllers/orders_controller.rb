class OrdersController < ApplicationController
  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result(distinct: true)
  end

  def new
    @order = Order.new
    @customers = Customer.all
    @products = Product.all
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:success] = 'Order successfully created'
      redirect_to orders_path
    else
      flash.now[:danger] = 'Correct the field'
      @customers = Customer.all
      @products = Product.all
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
    @customers = Customer.all
    @products = Product.all
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      flash[:success] = 'Order updated'
      redirect_to orders_path
    else
      flash.now[:danger] = 'Correct the field'
      @customers = Customer.all
      @products = Product.all
      render 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:success] = 'Order deleted'
    redirect_to orders_path
  end

  def change_order_status
    order = Order.find(params[:id])
    order.done ? order.update_attribute(:done, false)
               : order.update_attribute(:done, true)

    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :customer_id, :deadline)
  end
end
