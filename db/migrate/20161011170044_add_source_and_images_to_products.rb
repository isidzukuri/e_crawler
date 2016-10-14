class AddSourceAndImagesToProducts < ActiveRecord::Migration[5.0]
  def self.up
    add_column :products, :images, :text, default: ""
    add_column :products, :source, :string, default: "", null: false
  end

  def self.down
    remove_column :products, :images
    remove_column :products, :source
  end
end
