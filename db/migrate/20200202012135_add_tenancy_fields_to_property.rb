class AddTenancyFieldsToProperty < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :tenancy_start_date, :date
    add_column :properties, :tenancy_security_deposit, :float
    add_column :properties, :tenancy_monthly_rent, :float
    add_column :properties, :rented, :boolean, :default => false
    add_column :properties, :tenant_id, :integer
  end
end
