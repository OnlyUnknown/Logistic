class CreateAgents < ActiveRecord::Migration[7.0]
  def change
    create_table :agents do |t|
      t.index :id, unique: true
      t.string :name
      t.string :tasks, array: true, default: []
      t.integer :phone_number
      t.string :current_location

      t.timestamps
    end
  end
end
