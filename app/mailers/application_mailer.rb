class ApplicationMailer < ActionMailer::Base
  default from: "esaas.engagements@gmail.com",
          reply_to: 'esaas.engagements@gmail.com'
  layout 'mailer'
end
