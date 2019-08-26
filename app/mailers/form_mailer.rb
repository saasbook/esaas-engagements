class FormMailer < ApplicationMailer
  def send_form(name, email, url, iter, eng)
    @name = name
    @url = url
    @iter_num = iter.number
    @iter_end_date = iter.end_date.strftime('%F')
    @app_name = eng.app.name
    @team_names = eng.student_names
    mail(to: email, subject: "Iteration Feedback")
  end

  def mail_to(name, email, subject, content, sender)
    @sender = sender
    @org_contact_name = name
    @org_contact_email = email
    @subject = subject
    @content = content
    @sender = sender
    if sender.empty?
      mail(
        :subject => @subject,
        :to  => @org_contact_email,
        :html_body => @content,
        :track_opens => 'true')
    else
      mail(
        from: @sender,
        reply_to: @sender,
        :subject => @subject,
        :to  => @org_contact_email,
        :html_body => @content,
        :track_opens => 'true')
    end
  end
end
