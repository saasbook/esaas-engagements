class FormMailer < ApplicationMailer
	def send_form(name, email, url)
		@name = name
		@url = url
		mail(to: email, subject: "Iteration Feedback")
	end
end
