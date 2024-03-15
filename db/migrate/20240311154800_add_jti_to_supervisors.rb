class AddJtiToSupervisors < ActiveRecord::Migration[7.0]
  def change
    add_column :supervisors, :jti, :string, null: false
    add_index :supervisors, :jti, unique: true
  end
end
