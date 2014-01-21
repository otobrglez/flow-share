class AddPublicToFlows < ActiveRecord::Migration
  def change
    add_column :flows, :public, :integer, default: 0
  end
end
