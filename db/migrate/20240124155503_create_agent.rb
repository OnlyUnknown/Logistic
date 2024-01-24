class CreateAgent < ActiveRecord::Migration[7.0]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :tasks
      t.integer :number
      t.string :current_location

      t.timestamps
    end
  end
end
