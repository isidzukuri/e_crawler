class Admin::OrdersController < Admin::BaseController

  def index
    @items = Order.all
  end

  def edit
    @item = Order.find(params[:id])
  end

  def update
    @item = Order.find(params[:id])
    if @item.update(permited_params)
      add_flash 'Saved successfully'
      redirect_to admin_orders_path
    else
      render :edit
    end
  end

  def permited_params
    params.require(:order).permit(:order_status_id)
  end
end
