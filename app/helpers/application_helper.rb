module ApplicationHelper

  def categories_options id = nil
    options_from_collection_for_select(Category.all, :id, :title, id)
  end
end
