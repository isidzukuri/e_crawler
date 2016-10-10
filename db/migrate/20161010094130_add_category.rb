class AddCategory < ActiveRecord::Migration[5.0]
  def self.up
    create_table :categories do |t|
      t.string      :title
      t.references  :parent
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
