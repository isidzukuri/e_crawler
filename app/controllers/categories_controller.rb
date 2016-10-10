class CategoriesController < ApplicationController
  
  def index
    @items = @model.all
  end

  def show
    @item = @model.find(params[:id])
  end

  def new
    @item = @model.new
  end

  def create
    @item = @model.new(permited_params)
    if @item.save
      redirect_to @item
    else
      render "new"
    end
  end

  

  private
  def post_initialize
    @model = Category
    @permited_fields = :title
  end
end
