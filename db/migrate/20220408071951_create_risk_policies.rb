class CreateRiskPolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :risk_policies do |t|
      t.references :risk
      t.references :policy
      t.timestamps
    end
  end
end
