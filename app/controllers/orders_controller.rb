class OrdersController < ApplicationController
  load_and_authorize_resource except: [:create]

  def create
    if signed_in?
      create_item
      @order.save ? successful_creation : failed_creation
    else
      must_be_logged_in
    end
  end

  def show
    @item = Order.find(params[:id])
  end

  def index
    @items = current_user.orders
  end

  private

  def create_item
    @order = Order.create(user: current_user)
    basket.items.each do |product|
      @order.order_items << OrderItem.new(product_id: product, quantity: 1)
    end
  end

  def must_be_logged_in
    session[:previous_url] = basket_index_path
    redirect_to new_user_session_path
  end

  def successful_creation
    basket.empty
    add_flash 'Order created successfully'
    redirect_to @order
  end

  def failed_creation
    add_flash 'Order not valid', :error
    redirect_to basket_index_path
  end

  def basket
    @basket ||= Basket.new(session)
  end

end
