class CreateSupervisors < ActiveRecord::Migration[7.0]
  def change
    create_table :supervisors do |t|
      t.string :name
      t.string :tasks
      t.integer :number

      t.timestamps
    end
  end
end
