class CategoriesController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]

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
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
    if @item.update(permited_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def find_item
    @item = Product.find(params[:id])
  end

  def permited_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end
