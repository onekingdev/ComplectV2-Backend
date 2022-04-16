class ConvertProfileExperienceToString < ActiveRecord::Migration[7.0]
  def change
    change_column :profiles, :experience, :string
  end
end
