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
end
