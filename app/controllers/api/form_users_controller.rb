# Controller for api functionality related to events
class Api::FormUsersController < ApplicationController
  def create
    params[:form_user][:user_id] = helpers.hash_user_uin(params[:form_user][:user_id])
    @form_user = FormUser.new(form_user_params)

    head :created and return if @form_user.save

    head :bad_request and return
  end

  private

  def form_user_params
    params.require(:form_user).permit(:form_id, :user_id)
  end
end
