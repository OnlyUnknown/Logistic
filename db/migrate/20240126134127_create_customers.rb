class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.index :id, unique: true
      t.string :name
      t.integer :phone_number
      t.string :tasks, array: true, default: []

      t.timestamps
    end
  end
end
