class AddPropertyIdToTenant < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :property_id, :integer
  end
end
