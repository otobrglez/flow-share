class AddCommentToStep < ActiveRecord::Migration
  def change
    add_column :steps, :comment, :text, null: true
  end
end
