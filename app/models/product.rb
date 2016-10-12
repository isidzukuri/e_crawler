class Product < ApplicationRecord
  resourcify

  belongs_to :category

  validates :title, presence: true, length: { in: 2..200 }
  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { in: 0..2000 }

  def photos
    JSON.parse(images) if images.present?
  end

  def thumb
    photos.first if photos.present?
  end
end
