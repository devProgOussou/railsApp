class Api::V1::ProductsController < ApplicationController
  def index
    # ordered retrieve
    products = Product.order(:id)
    render json: products, status: 200
  end

  def show
    product = Product.find_by(id: params[:id])
    if product
      render json: product, status: 200
    else
      render json: {error: 'Product not found'}, status: 404
    end
  end

  def create
    product = Product.new(
      name: prod_params[:name],
      brand: prod_params[:brand],
      price: prod_params[:price]
    )
    if product.save
      render json: product, status: 200
    else
      render json: {error: 'Unable to create product'}, status: 400
    end
  end

  def update
    product = Product.find_by(id: params[:id])
    if product
      product.update(
        name: prod_params[:name],
        brand: prod_params[:brand],
        price: prod_params[:price]
      )
      render json: product, status: 200
    else
      render json: {error: 'Unable to update product'}, status: 400
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])
    if product
      product.destroy
      render json: {message: 'Product deleted'}, status: 200
    else
      render json: {error: 'Unable to delete product'}, status: 400
    end
  end

  private

  def prod_params
    params.require(:product).permit([
      :name, 
      :brand,
      :price
    ])
  end
end
