class Admin::OrdersController < Admin::BaseController

  def index
    @items = current_user.orders
  end

end
