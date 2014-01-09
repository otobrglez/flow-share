class AssociateRecords < ActiveRecord::Migration
  def change
    Flow.delete_all
    Step.delete_all

    change_table :flows do |t|
      t.integer :creator_id, null: false
    end

    add_index :flows, :creator_id

  end
end
