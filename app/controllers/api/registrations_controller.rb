# controller for password rotation
class Api::RegistrationsController < ApplicationController
  def update
    head :bad_request and return unless helpers.check_auth

    @admin = Admin.find_by(id: session[:current_user_id])
    @admin.password = params[:password]
    @admin.save
  end
end
