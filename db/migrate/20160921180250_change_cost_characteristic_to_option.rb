class ChangeCostCharacteristicToOption < ActiveRecord::Migration[5.0]
  def change
  	rename_column :costs, :category, :option 
  end
end
