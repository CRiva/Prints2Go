class CreateRequestAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :request_attachments do |t|
      t.integer :request_id
      t.string :file

      t.timestamps
    end
  end
end
