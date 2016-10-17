module OrderDecorator
  def status
    order_status.name
  end

  def items_count
    order_items.length
  end

  def email
    user.email
  end

  def status_options(id = nil)
    id ||= order_status_id
    options_from_collection_for_select(OrderStatus.all, :id, :name, id)
  end
end
