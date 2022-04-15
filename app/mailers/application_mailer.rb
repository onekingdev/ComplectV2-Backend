class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
  attr_reader :postmark

  def initialize(*args)
    @postmark = Postmark::ApiClient.new(ENV.fetch('POSTMARK_API_KEY'))
    super
  end

  def mail(headers = {}, &block)
    return deliver_with_template(headers) if (Rails.env.production? || Rails.env.staging?) && headers.key?(:template_id)
    return super if (Rails.env.production? || Rails.env.staging?) || !headers.key?(:template_id)

    super headers do |format|
      format.text do
        model = headers[:template_model].map { |var, value| "#{var}: #{value}" }.join("\n")
        render plain: "Template ID: #{headers[:template_id]}\n\n#{model}"
      end
    end
  end

  def self.deliver_later(method, *args)
    message = public_send(method, *args)
    later = ENV['ENABLE_DIRECT_MAILERS'] != '1'
    (Rails.env.production? || Rails.env.staging?) && later ? message.deliver_later : message.deliver_now
  end

  private

  def deliver_with_template(headers = {})
    postmark.deliver_with_template({ from: self.class.default[:from] }.merge(headers))
  rescue Postmark::InactiveRecipientError
    true
  end
end
