class RemoveBlackCoverFromRequests < ActiveRecord::Migration[5.0]
  def change
    remove_column :requests, :black_cover, :integer
  end
end
