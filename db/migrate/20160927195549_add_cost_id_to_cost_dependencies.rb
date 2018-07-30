class AddCostIdToCostDependencies < ActiveRecord::Migration[5.0]
  def change
    add_column :cost_dependencies, :cost_id, :integer
  end
end
