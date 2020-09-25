# Controller for handling registration of new admins
class Api::RegistrationsController < Devise::RegistrationsController
  def create
    @admin = Admin.new(user_params)
    if @admin.save
      render json: @admin
    else
      warden.custom_failure!
      render json: { error: 'signup error' }, status: :unprocessable_entity
    end
  end

  def update
    #   @admin = Admin.find_by_email(user_params[:email])

    #   if @admin.update_attributes(user_params)
    #     render json: @admin
    #   else
    #     warden.custom_failure!
    #     render :json=> @admin.errors, :status=>422
    #   end
  end

  def destroy
    #   @admin = Admin.find_by_email(user_params[:email])
    #   if @admin.destroy
    #     render :json=> { success: 'user was successfully deleted' }, :status=>201
    #   else
    #     render :json=> { error: 'user could not be deleted' }, :status=>422
    #   end
  end

  private

  def user_params
    params.require(:username).permit(:username, :password)
  end
end
