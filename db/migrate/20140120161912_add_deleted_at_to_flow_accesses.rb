class AddDeletedAtToFlowAccesses < ActiveRecord::Migration
  def change
    add_column :flow_accesses, :deleted_at, :datetime
  end
end
