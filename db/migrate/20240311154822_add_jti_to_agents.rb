class AddJtiToAgents < ActiveRecord::Migration[7.0]
  def change
    add_column :agents, :jti, :string, null: false
    add_index :agents, :jti, unique: true
  end
end
