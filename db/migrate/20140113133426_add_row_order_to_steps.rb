class AddRowOrderToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :row_order, :integer
  end
end
