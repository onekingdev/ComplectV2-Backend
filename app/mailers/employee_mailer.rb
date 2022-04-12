class EmployeeMailer < ApplicationMailer
  def send_invite(email, invite_hash)
    @invite_hash = invite_hash
    mail(
      to: email,
      template_id: ENV.fetch('POSTMARK_TEMPLATE_ID'),
      template_model: {
        subject: 'You have been invited to join organization',
        message_html: render_to_string(template: 'employee_mailer/send_invite.html.slim')
      }
    )
  end
end
