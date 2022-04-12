class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :invite_email
      t.datetime :start_date
      t.datetime :disabled_at
      t.string :disabled_reason
      t.text :additional_reason
      t.boolean :access_person
      t.string :role
      t.boolean :active
      t.string :invite_hash
      t.references :user
      t.references :business

      t.timestamps
    end
  end
end
