# Controller for api functionality related to events
class Api::FormUsersController < ApplicationController
  def create
    params[:form_user][:user_id] = helpers.hash_user_uin(unhashed_id)
    @form_user = FormUser.find_or_initialize_by(form_user_params)

    # unless @form_user.new_record?
    #   # In future sprints the existing record would be updated here
    #   head :ok and return if @form_user.save
    # end

    head :ok and return unless @form_user.new_record? # Done this way right now to satisfy rubocop

    if @form_user.save
      # FormUserMailer.with(form_user: @form_user).confirmation_email.deliver_later
      helpers.send_confirmation_email(@form_user)
      head :created and return
    end

    raise StandardError
  rescue StandardError
    head :bad_request and return
  end

  private

  def unhashed_id
    params[:form_user][:user_id]
  end

  def form_user_params
    params.require(:form_user).permit(:form_id, :user_id)
  end
end
