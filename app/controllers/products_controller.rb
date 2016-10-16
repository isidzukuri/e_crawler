class ProductsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :find_item, only: [:show, :edit]

  def index
    @items = Product.all
  end

  def new
    @item = Product.new
  end

  def create
    authorize! :create, Product
    @item = Product.new(permited_params)
    if @item.save
      flash[:success] = "Saved successfully"
      redirect_to @item
    else
      render :new
    end
  end

  def update
    @item = Product.find(params[:id])
    if @item.update(permited_params)
      flash[:success] = "Saved successfully"
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    @item = Product.find(params[:id])
    if @item
      @item.destroy 
      flash[:success] = "Destroyed successfully"
    else
      flash[:error] = "Product not found"
    end  
    redirect_to root_path
  end

  private

  def find_item
    @item = Product.eager_load(:category).find(params[:id])
  end

  def permited_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end
