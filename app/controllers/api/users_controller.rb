# Controller for api functionality related to users
class Api::UsersController < ApplicationController
  def handle_identification
    head :bad_request and return if params[:id].nil?

    @user = User.find(params[:id])
    head :created and return
  rescue ActiveRecord::RecordNotFound
    head :ok and return
  end

  def create
    # Evelio, perform a check here and make sure that the UIN isn't already in the system
    @user = User.new(user_params)
    head :created and return if @user.save

    head :bad_request and return
  rescue StandardError
    head :bad_request and return
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :major, :graduation_year, :email, :phone_number)
  end
end
