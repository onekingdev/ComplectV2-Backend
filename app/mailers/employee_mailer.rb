class EmployeeMailer < ApplicationMailer
  def send_invite(email, invite_hash)
    @invite_hash = invite_hash
    mail(
      to: email,
      template_id: ENV.fetch('POSTMARK_TEMPLATE_ID'),
      template_model: {
        subject: I18n.t("employee_mailer.send_invite.subject"),
        message_html: render_to_string(template: 'employee_mailer/send_invite')
      }
    )
  end

  def send_disabled(email)
    mail(
      to: email,
      template_id: ENV.fetch('POSTMARK_TEMPLATE_ID'),
      template_model: {
        subject: I18n.t("employee_mailer.send_disabled.subject"),
        message_html: render_to_string(template: 'employee_mailer/send_disabled.html.slim')
      }
    )
  end
end
