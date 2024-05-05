class AddAvailabilityToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :availability, :string
  end
end
