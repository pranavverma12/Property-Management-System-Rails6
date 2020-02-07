class CreateLandlords < ActiveRecord::Migration[6.0]
  def change
    create_table :landlords do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: true, foreign_key: true

      t.timestamps
    end
  end
end
