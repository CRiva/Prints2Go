class CreateCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :costs do |t|
      t.string :characteristic
      t.decimal :per_job, precision:5, scale:2
      t.decimal :per_page, precision: 5, scale:2
    end
  end
end
