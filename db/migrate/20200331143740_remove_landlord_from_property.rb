class RemoveLandlordFromProperty < ActiveRecord::Migration[6.0]
  def change

    remove_column :properties, :landlord_first_name, :string

    remove_column :properties, :landlord_last_name, :string

    remove_column :properties, :landlord_email, :string

    remove_column :properties, :multiple_landlords, :boolean

    remove_column :properties, :other_landlords_emails, :text

    remove_column :properties, :tenants_emails, :text
  end
end
