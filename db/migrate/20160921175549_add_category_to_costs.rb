class AddCategoryToCosts < ActiveRecord::Migration[5.0]
  def change
    add_column :costs, :category, :string
  end
end
