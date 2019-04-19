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

  def mail_all_orgs(name, email, subject, content)
    @org_contact_name = name
    @org_contact_email = email
    @subject = subject
    @content = content
    mail(to: @org_contact_email, subject: subject)
  end
end
