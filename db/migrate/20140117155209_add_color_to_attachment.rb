class AddColorToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :color, :string, default: nil
  end
end
