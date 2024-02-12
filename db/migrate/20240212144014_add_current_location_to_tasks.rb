class AddCurrentLocationToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :current_location, :string
  end
end
