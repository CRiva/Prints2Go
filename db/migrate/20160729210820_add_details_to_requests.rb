class AddDetailsToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :requester, :string
    add_column :requests, :status, :string
    add_column :requests, :pickup_date, :text
    add_column :requests, :costcenter, :string
    add_column :requests, :costcenter_number, :string
    add_column :requests, :originals, :string
    add_column :requests, :sides, :string
    add_column :requests, :stock, :string
    add_column :requests, :binding, :string
    add_column :requests, :folding, :string
    add_column :requests, :color_copy, :integer
    add_column :requests, :collate, :integer
    add_column :requests, :staple, :integer
    add_column :requests, :threehole, :integer
    add_column :requests, :cut, :integer
    add_column :requests, :laminate, :integer
    add_column :requests, :pad, :integer
    add_column :requests, :color, :string
    add_column :requests, :special_info, :text
    add_column :requests, :cost, :decimal
    add_column :requests, :completion, :string
    add_column :requests, :copies, :integer
    add_column :requests, :size, :string
    add_column :requests, :weight, :string
    add_column :requests, :finish, :string
    add_column :requests, :estimate, :decimal, :default => 0.04
    add_column :requests, :clear_cover, :integer
    add_column :requests, :black_cover, :integer
    add_column :requests, :otherestimate, :decimal, :default => 0.00
    add_column :requests, :billed, :boolean, :default => false
  end
end
