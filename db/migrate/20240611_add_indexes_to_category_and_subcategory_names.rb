class AddIndexesToCategoryAndSubcategoryNames < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :name
    add_index :subcategories, :name
  end
end
