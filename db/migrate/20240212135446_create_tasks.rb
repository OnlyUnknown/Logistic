class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :product
      t.string :sender
      t.integer :quantity
      t.integer :receiver
      t.string :status
      t.float :price
      t.float :total

      t.timestamps
    end
  end
end
