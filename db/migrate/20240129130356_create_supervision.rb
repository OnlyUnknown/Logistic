class CreateSupervision < ActiveRecord::Migration[7.0]
  def change
    create_table :supervisions do |t|
      t.references :agent, null: false, foreign_key: true
      t.references :supervisor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
