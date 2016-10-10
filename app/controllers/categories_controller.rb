class CategoriesController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @items = Category.all
  end
end
