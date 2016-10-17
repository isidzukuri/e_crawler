class OrdersController < ApplicationController
  load_and_authorize_resource except: [:create]

  def create
    authorize! :create, Order

    @order = Order.create(user: current_user)
    products.each do |product|
      @order.order_items << OrderItem.new(product_id: product, quantity: 1)
    end
    if @order.save
      successful_creation
    else
      redirect_to basket_index_path
    end
  end

  def show
    @item = Order.find(params[:id])
  end

  def index
    @items = current_user.orders
  end


  private

  def successful_creation
    empty_basket
    add_flash 'Order created successfully'
    redirect_to @order
  end

  def products
    session[:products]
  end

  def empty_basket
    session[:products] = nil
  end

end
