class AddDeviseTwoFactorToUsers < ActiveRecord::Migration[7.0]
  def change
    # add_column :users, :encrypted_otp_secret, :string
    # add_column :users, :encrypted_otp_secret_iv, :string
    # add_column :users, :encrypted_otp_secret_salt, :string
    add_column :users, :otp_secret, :text
    add_column :users, :consumed_timestep, :integer
    add_column :users, :otp_required_for_login, :boolean, default: true
  end
end
