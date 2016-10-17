module OrderDecorator
  def status
    order_status.name
  end

  def items_count
    order_items.length
  end
end
