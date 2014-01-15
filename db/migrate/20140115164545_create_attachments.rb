class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :name
      t.string :content_type, default: nil
      t.integer :file_size, default: 0
      t.references :attachable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
