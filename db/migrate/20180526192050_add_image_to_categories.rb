class AddImageToCategories < ActiveRecord::Migration[5.1]
   def up
    add_attachment :categories, :image
  end

  def down
    remove_attachment :categories, :image
  end
end
