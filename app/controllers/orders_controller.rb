class OrdersController < ApplicationController
  load_and_authorize_resource except: [:create]

  def create
    authorize! :create, Order

      # take products from basket
    # create order items
    # create order
    @order = Order.create(user: current_user)
    products.each do |product|
      # OrderItem.create(order: @order, product_id: product, quantity: 1)
      @order.order_items << OrderItem.new(product_id: product, quantity: 1)
    end
    # @order.subtotal

    # @item = Category.new(permited_params)
    if @order.save
      add_flash 'Created successfully'
      redirect_to @order
    else
      redirect_to basket_index_path
    end

    # remove items from basket
    # flash
    # redirect to created order
    # render :show
  end


  private

  def products
    session[:products]
  end

  def empty_basket
    session[:products] = nil
  end

  # def permited_params
  #   params.require(:category).permit(:title, :parent_id)
  # end

end
