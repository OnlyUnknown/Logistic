class CreateSupervisors < ActiveRecord::Migration[7.0]
  def change
    create_table :supervisors do |t|
      t.index :id, unique: true
      t.string :name
      t.string :tasks, array: true, default: []
      t.integer :phone_number

      t.timestamps
    end
  end
end
