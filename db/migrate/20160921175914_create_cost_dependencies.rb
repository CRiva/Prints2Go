class CreateCostDependencies < ActiveRecord::Migration[5.0]
  def change
    create_table :cost_dependencies do |t|
      t.string :dependency_category
      t.string :dependency_option
      t.decimal :per_page, precision: 5, scale: 2, default: "0.0"
      t.decimal :per_job, precision: 5, scale: 2, default: "0.0"
    end
  end
end
