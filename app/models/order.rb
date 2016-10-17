class Order < ApplicationRecord
  resourcify
  belongs_to :order_status
  belongs_to :user
  has_many :order_items
  before_create :set_order_status
  before_save :update_total

  validate :user_present

  def subtotal
    order_items.collect(&:total_price).sum
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

  def update_total
    self.total = subtotal
  end

  def user_present
    errors.add(:user, 'is not a valid user.') if user.nil?
  end
end
