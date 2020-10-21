# Helper functions for form users controller
module FormUsersHelper
  def send_confirmation_email(form_user)
    FormUserMailer.with(form_user: form_user).confirmation_email.deliver_later
  end
end
