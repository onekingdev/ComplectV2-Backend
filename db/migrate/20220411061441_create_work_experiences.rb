class CreateWorkExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :work_experiences do |t|
      t.references :profile
      t.string :title, null: false
      t.string :employer, null: false
      t.text :description
      t.datetime :starts_on, null: false
      t.datetime :ends_on
      t.boolean :is_present
      t.timestamps
    end
  end
end
