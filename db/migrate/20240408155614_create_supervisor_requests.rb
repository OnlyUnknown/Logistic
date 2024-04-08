class CreateSupervisorRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :supervisor_requests do |t|
      t.references :agent, null: false, foreign_key: true
      t.references :supervisor, null: false, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
