class RemoveAchievedAtFromSteps < ActiveRecord::Migration
  def change
    remove_column :steps, :achieved_at
  end
end
