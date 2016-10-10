class CategoriesController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = @model.all
  end

  def new
    @item = @model.new
  end

  def create
    @item = @model.new(permited_params)
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
    redirect_to '/'
  end

  private

  def post_initialize
    @model = Category
    @permited_fields = :title
  end

  def find_item
    @item = @model.find(params[:id])
  end

  def permited_params
    parameter_name = @model.name.downcase.to_sym
    params.require(parameter_name).permit(@permited_fields)
  end
end
