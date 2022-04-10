class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id
      t.string :time_zone
      t.string :address
      t.string :apt_unit
      t.string :city
      t.string :state
      t.string :phone_number
      t.string :zipcode
      t.boolean :availability
      t.boolean :former_regulator
      t.decimal :hourly_rate
      t.jsonb :avatar_data
      t.jsonb :file_data

      t.timestamps
    end
  end
end
