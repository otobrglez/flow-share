class AddOpenToFlows < ActiveRecord::Migration
  def change
    add_column :flows, :open, :integer, default: 0
  end
end
