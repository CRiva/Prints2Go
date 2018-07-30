class FixCostCharacteristicToOption < ActiveRecord::Migration[5.0]
  def change
  	rename_column :costs, :characteristic, :category 
  end
end
