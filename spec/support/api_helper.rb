module ApiHelper
  def get_token(user)
    user.password = '123456789'
    user.save
    post "/users/sign_in", params: { user: { email: user.email, password: '123456789' } }, as: :json
    post "/users/sign_in", params: { user: { email: user.email, password: '123456789', otp_attempt: User.find(user.id).current_otp } }, as: :json
    response.headers['Authorization']
  end
end
