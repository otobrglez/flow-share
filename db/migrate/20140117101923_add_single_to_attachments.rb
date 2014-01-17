class AddSingleToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :single, :integer, default: 0
  end
end
