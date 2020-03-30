class CreatePropertyTenants < ActiveRecord::Migration[6.0]
  def change
    create_table :property_tenants do |t|
      t.references :property, null: false, foreign_key: true, index: true
      t.references :tenant, null: false, foreign_key: true, index: true

      t.timestamps  
    end
    
    add_index :property_tenants, %i[property_id tenant_id], unique: true
  end
end
