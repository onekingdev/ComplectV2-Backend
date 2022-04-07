class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |t|
      t.string :name, null: false
      t.datetime :starts_on, null: false
      t.datetime :ends_on, null: false
      t.datetime :completed_at
      t.string :share_uuid, index: true, unique: true
      t.string :status, default: 'inprogress'
      t.references :user
      t.integer :updated_by_id, index: true
      t.integer :business_id, index: true
      t.timestamps
    end
  end
end
