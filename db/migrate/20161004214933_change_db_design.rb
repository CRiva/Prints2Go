class ChangeDbDesign < ActiveRecord::Migration[5.0]
  def change
  	change_column :requests, :color_copy, :string
  end
end
