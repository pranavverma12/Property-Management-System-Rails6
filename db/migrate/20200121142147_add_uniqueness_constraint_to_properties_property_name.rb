# frozen_string_literal: true

class AddUniquenessConstraintToPropertiesPropertyName < ActiveRecord::Migration[6.0]
  def change
    add_index :properties, :property_name, unique: true
  end
end
