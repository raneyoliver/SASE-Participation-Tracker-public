# controller for password rotation
class Api::RegistrationsController < ApplicationController
  def update
    head :bad_request and return unless helpers.check_auth

    @admin = Admin.find_for_authentication(username: 'Admin')
    @admin.password = params[:password]
    @admin.save
  end
end
