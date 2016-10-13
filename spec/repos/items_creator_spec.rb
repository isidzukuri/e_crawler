require 'rails_helper'

RSpec.describe ItemsCreator do
  before :all do
    @item = {
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph,
      price: Faker::Number.digit,
      source: Faker::Internet.url,
      images: [Faker::Internet.url, Faker::Internet.url, Faker::Internet.url].to_json
    }
    @items = Array.new(3, @item)
    @category = Category.find_or_create_by(title: 'Test')
  end

  describe '#bulk_create' do
    it 'shold insert items into db' do
      before_count = Product.count
      ItemsCreator.bulk_create(:product, @items)
      expect(Product.count - before_count).to eq 3
    end

    it 'shold be same as setted' do
      ItemsCreator.bulk_create(:product, @items)
      expect(Product.last.title).to eq @item[:title]
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
      items = Array.new(103, @item)
      ItemsCreator.bulk_create(:product, items, category_id: @category.id)
      expect(Product.last.category_id).to eq @category.id
    end
  end
end
