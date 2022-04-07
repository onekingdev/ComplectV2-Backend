class CreateExamRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :exam_requests do |t|
      t.references :exam
      t.references :user
      t.string :name
      t.text :details
      t.jsonb :text_items
      t.boolean :shared
      t.integer :shared_by_id, index: true
      t.integer :updated_by_id, index: true
      t.timestamps
    end
  end
end
