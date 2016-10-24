class BasketController < ApplicationController
  def index
    @items = Product.find(basket.items.to_a)
    @summary = @items.sum(&:price)
    @order = Order.new
  end

  def update
    basket.add(params[:id])
    render json: true
  end

  def remove
    basket.remove(params[:id])
    render json: true
  end

  private

  def basket
    @basket ||= Basket.new(session)
  end

end
