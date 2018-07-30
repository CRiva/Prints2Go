class AddBlackBackToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :black_back, :integer
  end
end
