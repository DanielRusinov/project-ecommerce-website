class AddStripeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_token, :string
    add_column :users, :stripe_email, :string
  end
end
