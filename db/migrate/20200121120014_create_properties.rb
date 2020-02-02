# frozen_string_literal: true

class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :property_name, null: false
      t.string :property_address, null: false
      t.string :landlord_first_name, null: false
      t.string :landlord_last_name, null: false
      t.string :landlord_email, null: false

      t.timestamps
    end
  end
end
