class ChangeNameOfStep < ActiveRecord::Migration
  def change
    change_column :steps, :name, :text
    remove_column :steps, :comment
  end
end
