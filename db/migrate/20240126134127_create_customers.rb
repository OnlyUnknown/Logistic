class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :phone_number
      t.string :tasks

      t.timestamps
    end
  end
end
