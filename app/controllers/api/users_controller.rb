# Controller for api functionality related to users
class Api::UsersController < ApplicationController
  def handle_identification
    head :bad_request and return if params[:id].nil?

    @user = User.find(helpers.hash_user_uin(params[:id]))

    head :created and return
  rescue ActiveRecord::RecordNotFound
    head :ok and return
  end

  def create
    @user = User.new(user_params)

    if @user.save
      helpers.send_new_user_email(@user)
      head :created and return
    end

    head :bad_request and return
  rescue ActiveRecord::RecordNotUnique
    head :conflict and return
  rescue StandardError
    head :bad_request and return
  end

  private

  def user_params
    params[:user][:id] = helpers.hash_user_uin(params[:user][:id])
    params.require(:user).permit(:id, :first_name, :last_name, :major, :graduation_year, :email, :phone_number)
  end
end
