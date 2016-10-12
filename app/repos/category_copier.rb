class CategoryCopier
  def self.copy(type, url, category_id)
    new(type, category_id).copy(url)
  end

  def initialize(type, category_id)
    @crawler = type.to_s.classify.constantize
    @category_id = category_id.to_i
  end

  def copy(url)
    items = @crawler.copy(url)
    ItemsCreator.bulk_create :product, items, @category_id
  end
end
