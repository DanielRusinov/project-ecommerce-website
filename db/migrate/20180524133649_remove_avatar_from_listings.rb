class RemoveAvatarFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :avatar_file_name, :string
    remove_column :listings, :avatar_content_type, :string
    remove_column :listings, :avatar_file_size, :integer
    remove_column :listings, :avatar_updated_at, :datetime
  end
end
