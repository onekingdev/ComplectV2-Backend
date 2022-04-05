class CreateRisks < ActiveRecord::Migration[7.0]
  def change
    create_table :risks do |t|
      t.string :name, null: false
      t.references :user
      t.integer :updated_by_id, index: true
      t.integer :business_id, index: true
      t.string :impact
      t.string :likelihood
      t.string :level
      t.timestamps
    end
  end
end
