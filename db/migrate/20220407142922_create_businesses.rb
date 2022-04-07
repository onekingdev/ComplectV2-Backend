class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :business_name
      t.string :crd
      t.integer :aum
      t.integer :accounts
      t.string :time_zone
      t.string :phone_number
      t.string :website
      t.string :address
      t.string :apt_unit
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :user_id
      t.jsonb :logo
      t.integer :payment_method_id
      t.string :stripe_customer_id

      t.timestamps
    end
  end
end
