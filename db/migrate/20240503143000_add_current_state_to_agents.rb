class AddCurrentStateToAgents < ActiveRecord::Migration[7.0]
  def change
    add_column :agents, :current_state, :string
  end
end
