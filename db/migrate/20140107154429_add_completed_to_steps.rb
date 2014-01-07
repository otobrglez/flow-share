class AddCompletedToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :completed, :integer, default: 0, null: false
  end
end
