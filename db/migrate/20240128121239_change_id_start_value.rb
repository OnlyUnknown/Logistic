class ChangeIdStartValue < ActiveRecord::Migration[7.0]
  def change
    "CREATE SEQUENCE supervisor_id
START 10;"
  end
end
