class ChangeJobAndPageDefaultCost < ActiveRecord::Migration[5.0]
  def change
  	change_column_default(:costs, :per_job, 0.0)
  	change_column_default(:costs, :per_page, 0.0)
  end
end
