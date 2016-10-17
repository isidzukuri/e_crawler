class AddUserIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :user, index: true
  end
end
