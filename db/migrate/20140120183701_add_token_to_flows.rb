class AddTokenToFlows < ActiveRecord::Migration
  def change
    add_column :flows, :token, :string, limit: 10
    add_index :flows, :token, unique: true
  end

end
