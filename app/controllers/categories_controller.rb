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
      add_flash 'Saved successfully'
      redirect_to @item
    else
      render :new
    end
  end

  def update
    if @item.update(permited_params)
      add_flash 'Saved successfully'
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    if @item
      @item.destroy
      add_flash 'Destroyed successfully'
    else
      add_flash 'Category not found', :error
    end
    redirect_to root_path
  end

  def copy_category
    CopyWorker.perform_async(:la_lv, params[:url], params[:id], current_user.id)
  end

  private

  def find_item
    @item = Category.find(params[:id])
  end

  def permited_params
    params.require(:category).permit(:title, :parent_id)
  end
end
