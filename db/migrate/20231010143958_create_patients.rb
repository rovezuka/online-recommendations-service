class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :full_name
      t.date :date_of_birth
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
