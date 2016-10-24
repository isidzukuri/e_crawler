class Product < ApplicationRecord
  resourcify

  belongs_to :category

  validates :title, presence: true, length: { in: 2..200 }
  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { in: 0..2000 }
  validates :source, uniqueness: true, if: 'source.present?'
end
