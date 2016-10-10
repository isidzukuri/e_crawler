class AddProduct < ActiveRecord::Migration[5.0]
  def self.up
    create_table :products do |t|
      t.string      :title, null: false
      t.text        :description, default: ""
      t.integer     :price, unsigned: true, default: 0
      t.references  :category
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
