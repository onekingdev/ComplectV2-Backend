class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :confirmable, :two_factor_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist,
                               otp_secret_encryption_key: ENV['OTP_SECRET_KEY']

  has_many :exams
  has_many :exam_requests
  has_many :share_exams
  has_many :work_experiences
end
