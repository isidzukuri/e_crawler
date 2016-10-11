class Category < ApplicationRecord
  resourcify

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category'
  has_many :products

  validates :title, presence: true, length: { in: 2..200 }
end
