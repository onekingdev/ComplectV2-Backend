class OtpMailer < ApplicationMailer
  def send_otp(email, otp)
    @otp_code = otp
    mail(
      to: email,
      template_id: ENV.fetch('POSTMARK_TEMPLATE_ID'),
      template_model: {
        subject: 'Your verification code',
        message_html: render_to_string(template: 'otp_mailer/send_otp')
      }
    )
  end
end
