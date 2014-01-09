class CreateFlowAccesses < ActiveRecord::Migration
  def change
    create_table :flow_accesses do |t|
      t.references :flow, index: true, null: false
      t.references :user, index: true, null: false
      t.string :role, default: :creator, null: false
      t.timestamps
    end
  end
end
