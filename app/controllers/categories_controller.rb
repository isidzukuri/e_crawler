class CategoriesController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Category.all
  end

  def new
    @item = Category.new
  end

  def create
    authorize! :create, Category
    @item = Category.new(permited_params)
    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  def update
    if @item.update(permited_params)
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if @item
    redirect_to root_path
  end

  private

  def find_item
    @item = Category.find(params[:id])
  end

  def permited_params
    params.require(:category).permit(:title, :parent_id)
  end
end
