class AddEditorToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :editor, :integer
  end
end
