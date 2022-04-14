class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :confirmable
  devise :registerable, :two_factor_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist,
                               otp_secret_encryption_key: ENV['OTP_SECRET_KEY']

  has_many :exams
  has_many :exam_requests
  has_many :share_exams
  has_many :risks
  has_many :policies
  has_one :profile, dependent: :destroy
  has_one :business
  has_one :employee, dependent: :destroy
  accepts_nested_attributes_for :profile

  validates :kind, presence: true
  validates :profile, presence: true

  enum kind: { specialist: 'specialist', employee: 'employee' }

  def send_otp
    puts "\n**** OTP: ****\n*   #{current_otp}   *\n**************\n\n" if Rails.env == "development"
    OtpMailer.send_otp(email, current_otp).deliver_later if Rails.env != "development"
  end
end
