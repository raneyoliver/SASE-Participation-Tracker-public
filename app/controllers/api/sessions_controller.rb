# Controller for handling user sessions
class Api::SessionsController < Devise::SessionsController
  def create
    @admin = Admin.find_for_authentication(username: params[:username])
    return invalid_login_attempt unless @admin

    if @admin.valid_password?(params[:password])
      session[:current_user_id] = @admin.id
      sign_in :admin, @admin
      render json: { success: true }
    else
      invalid_login_attempt
    end
  end

  # def destroy
  #   sign_out(@admin)
  #   render json: { success: true }
  # end

  private

  def invalid_login_attempt
    warden.custom_failure!
    render json: { error: 'invalid login attempt' }, status: :unprocessable_entity
  end
end
