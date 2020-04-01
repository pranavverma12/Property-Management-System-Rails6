class CreatePropertyLandlords < ActiveRecord::Migration[6.0]
  def change
    create_table :property_landlords do |t|
      t.references :property, null: false, foreign_key: true, index: true
      t.references :landlord, null: false, foreign_key: true, index: true

      t.timestamps
    end

    add_index :property_landlords, %i[property_id landlord_id], unique: true
  end
end
