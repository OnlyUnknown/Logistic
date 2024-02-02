class ChangeIdStartValue < ActiveRecord::Migration[7.0]
  def change
    execute "SELECT setval('supervisors_id_seq', 10000000)"
    execute "ALTER TABLE supervisors ALTER COLUMN id SET DEFAULT nextval('supervisors_id_seq')"
    execute "SELECT setval('agents_id_seq', 20000000)"
    execute "ALTER TABLE supervisors ALTER COLUMN id SET DEFAULT nextval('supervisors_id_seq')"
    execute "SELECT setval('customers_id_seq', 30000000)"
    execute "ALTER TABLE supervisors ALTER COLUMN id SET DEFAULT nextval('supervisors_id_seq')"
  end
end
