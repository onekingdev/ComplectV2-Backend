class CreateShareExams < ActiveRecord::Migration[7.0]
  def change
    create_table :share_exams do |t|
      t.references :user
      t.references :exam
      t.string :invited_email
      t.string :otp
      t.datetime :otp_requested
      t.datetime :viewed_at
      t.integer :updated_by_id, index: true
      t.timestamps
    end
  end
end
