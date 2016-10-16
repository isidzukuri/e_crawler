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
      flash[:success] = "Saved successfully"      
      redirect_to @item
    else
      render :new
    end
  end

  def update
    if @item.update(permited_params)
      flash[:success] = "Saved successfully"
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    if @item
      @item.destroy 
      flash[:success] = "Destroyed successfully"
    else
      flash[:error] = "Category not found"
    end  
    redirect_to root_path
  end

  def copy_category
    result = CategoryCopier.copy(:la_lv, params[:url], params[:id])
    if result[:error]
      flash[:error] = result[:error]
    else
      flash[:success] = "Coping of #{params[:url]} completed."
    end

    # test exceptions

    # result = { status: true }
    # begin
    #   CategoryCopier.copy(:la_lv, params[:url], params[:id])
    # rescue Exception => e
    #   result = { status: false, error: e.message }
    # end
    # render json: result
  end

  private

  def find_item
    @item = Category.find(params[:id])
  end

  def permited_params
    params.require(:category).permit(:title, :parent_id)
  end
end
