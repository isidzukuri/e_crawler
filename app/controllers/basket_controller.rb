class BasketController < ApplicationController
  def index
    @items = Product.find(products.to_a)
    @summary = @items.sum(&:price)
    @order = Order.new
  end

  def update
    items = products
    items << params[:id].to_i
    session[:products] = items
    render json: true
  end

  def remove
    products.delete(params[:id].to_i)
    render json: true
  end

  private

  def products
    session[:products] || Set.new
  end
end
