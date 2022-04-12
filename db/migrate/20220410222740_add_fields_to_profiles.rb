class AddFieldsToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :experience, :integer
    add_column :profiles, :show_full_name, :boolean
  end
end
