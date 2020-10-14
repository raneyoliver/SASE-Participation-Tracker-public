# Mailer for emails related to form_users
class FormUserMailer < ApplicationMailer
  default from: 'saseparticipationtracker@gmail.com'

  def confirmation_email
    @form_user = params[:form_user]
    @name = "#{@form_user.user.first_name} #{@form_user.user.last_name}"
    subject = "Form submission confirmation for event: #{@form_user.form.event.name}"
    mail(to: @form_user.user.email, subject: subject)
  end
end
