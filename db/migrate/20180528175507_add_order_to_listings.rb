class AddOrderToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :order_first, :boolean
  end
end
