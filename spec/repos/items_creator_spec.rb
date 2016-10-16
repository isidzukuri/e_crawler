require 'rails_helper'

RSpec.describe ItemsCreator do
  before :all do
    @items = Array.new(3, create_item)
    @category = Category.find_or_create_by(title: 'Test')
  end

  def create_item
    {
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph,
      price: Faker::Number.digit,
      source: Faker::Internet.url,
      images: [Faker::Internet.url, Faker::Internet.url, Faker::Internet.url].to_json
    }
  end

  describe '#bulk_create' do
    it 'shold insert items into db' do
      before_count = Product.count
      ItemsCreator.bulk_create(:product, @items)
      expect(Product.count - before_count).to eq 3
    end

    it 'shold be same as setted' do
      title = @items.last[:title]
      ItemsCreator.bulk_create(:product, @items)
      expect(Product.last.title).to eq title
    end

    it 'shold save items with unique source only' do
      item = create_item
      Product.create(item)
      before_count = Product.count
      items = [item, create_item]
      ItemsCreator.bulk_create(:product, items)
      expect(Product.count - before_count).to eq 1
    end

    it 'shold insert items into db with additional params' do
      before_count = Product.count
      ItemsCreator.bulk_create(:product, @items, category_id: @category.id)
      expect(Product.count - before_count).to eq 3
    end

    it 'shold insert items into db with additional params' do
      ItemsCreator.bulk_create(:product, @items, category_id: @category.id)
      expect(Product.last.category_id).to eq @category.id
    end

    it 'shold insert items in 2 transactions' do
      before_count = Product.count
      items = Array.new(101, create_item)
      ItemsCreator.bulk_create(:product, items, category_id: @category.id)
      expect(Product.count - before_count).to eq 101
    end
  end
end
