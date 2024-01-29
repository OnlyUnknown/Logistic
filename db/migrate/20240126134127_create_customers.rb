class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.index :id, unique: true
      t.string :name
      t.integer :phone_number
      t.string :tasks

      t.timestamps
    end
  end
