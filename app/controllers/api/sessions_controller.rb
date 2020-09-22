class Api::SessionsController < Devise::SessionsController

    def create
      @user = User.find_for_authentication(:username => params[:username])
      return invalid_user unless @user
  
      if @user.valid_password?(params[:password])
        sign_in :user, @user
        render json: @user
      else
        invalid_login_attempt
      end
    end
  
    def destroy
      sign_out(@user)
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
  
  end