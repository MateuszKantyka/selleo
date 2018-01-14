class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = 'Product created'
      redirect_to products_path
    else
      flash.now[:danger] = 'Correct the field'
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = 'Product updated'
      redirect_to products_path
    else
      flash.now[:danger] = 'Correct the field'
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = 'Product deleted'
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name)
  end
end
