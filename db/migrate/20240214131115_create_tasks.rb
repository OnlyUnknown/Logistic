class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.index :id, unique: true
      t.references :supervisor, null: false, foreign_key: true
      t.string :product
      t.belongs_to :agent, foreign_key: true, index: true
      t.integer :quantity
      t.belongs_to :customer, foreign_key: true, index: true
      t.string :status
      t.float :price
      t.string :current_location
      t.float :total

      t.timestamps
    end
  end
end
