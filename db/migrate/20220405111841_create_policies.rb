class CreatePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :policies do |t|
      t.string :name, null: false
      t.text :description
      t.integer :position
      t.string :status, default: 'draft'
      t.integer :src_id, index: true
      t.datetime :published_at
      t.integer :published_by_id, index: true
      t.datetime :archived_at
      t.integer :archived_by_id, index: true
      t.integer :business_id, index:true
      t.references :user
      t.integer :updated_by_id, index: true
      t.timestamps
    end
  end
end
