class AssigneeToSteps < ActiveRecord::Migration
  def change
    change_table :steps do |t|
      t.references :assignee, index: true
      t.references :achiever, index: true
    end
  end

end
