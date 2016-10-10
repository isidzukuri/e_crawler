class BasketController < ApplicationController

  def index
    # push 1
    # push 2

    @items = Product.find(products.to_a)
    @summary = @items.map {|s| s[:price]}.reduce(0, :+)
  end

  def add
    push params[:id]
  end

  def remove
    products.delete(params[:id])
  end

  private

  def products
    session[:products] || Set.new
  end

  def push id
    items = products
    items << id.to_i
    session[:products] = items
  end

end
