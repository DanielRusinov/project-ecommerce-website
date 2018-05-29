class RemoveStripEmailFromUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :stripe_email
  end
end
