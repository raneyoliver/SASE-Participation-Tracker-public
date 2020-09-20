# Controller for api functionality related to attendees
class Api::AttendeesController < ApplicationController
  def create_form_record_if_attendee_exists
    head :bad_request and return if params[:UIN].nil?

    @attendee = Attendee.find(params[:UIN])
    head :created and return
  rescue ActiveRecord::RecordNotFound
    head :ok and return
  end

  def create_attendee_and_form_record
    @attendee = Attendee.new(attendee_params)
    head :created and return if @attendee.save

    head :bad_request and return
  rescue StandardError
    head :bad_request and return
  end

  private

  def attendee_params
    params.require(:attendee).permit(:UIN, :first_name, :last_name, :major, :graduation_year, :email, :phone_number)
  end
end
