# Helper methods for Application
module ApplicationHelper
  def check_auth
    return Admin.find_by(id: session[:current_user_id])
  end
end
