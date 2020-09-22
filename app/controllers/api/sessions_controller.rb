class Api::SessionsController < Devise::SessionsController

    def create
      @admin = Admin.find_for_authentication(:username => params[:username])
      return invalid_user unless @admin
  
      if @admin.valid_password?(params[:password])
        sign_in :admin, @admin
        redirect_to '/'
      else
        invalid_login_attempt
      end
    end
  
    def destroy
      sign_out(@admin)
      render :json=> {:success=>true}
    end

      private
      def invalid_user
        warden.custom_failure!
        render json: {error: 'invalid user'}, status: :unprocessable_entity
      end

      def invalid_login_attempt
        warden.custom_failure!
        render json: {error: 'invalid login attempt'}, status: :unprocessable_entity
      end
  
      def user_params
         params.require(:username).permit(:username, :password)
      end

      def after_sign_in_path_for(resource)
        admins_path
      end
  
  end