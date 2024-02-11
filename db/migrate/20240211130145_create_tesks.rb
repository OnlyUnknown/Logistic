class CreateTesks < ActiveRecord::Migration[7.0]
  def change
    create_table :tesks do |t|
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
