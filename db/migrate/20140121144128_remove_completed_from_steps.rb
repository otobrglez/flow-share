class RemoveCompletedFromSteps < ActiveRecord::Migration
  def change
    remove_column :steps, :completed
    add_column :steps, :achieved_at, :datetime
  end
end
