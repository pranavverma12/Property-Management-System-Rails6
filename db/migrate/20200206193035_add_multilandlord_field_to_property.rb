class AddMultilandlordFieldToProperty < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :multiple_landlords, :boolean, default: false
    add_column :properties, :other_landlords_emails, :text, array: true
  end
end
