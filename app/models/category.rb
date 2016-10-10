class Category < ApplicationRecord
  resourcify
  
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category"

  validates :title, :presence => true, :length => { :in => 2..200 }
end
