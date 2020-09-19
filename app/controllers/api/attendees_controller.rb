# Controller for api functionality related to attendees
class Api::AttendeesController < ApplicationController
  
    def create_form_record_if_attendee_exists
      begin
        @attendee = Attendee.find(params[:UIN])
        head :created and return
      rescue ActiveRecord::RecordNotFound
        head :ok and return
        return
      rescue StandardError
        head :bad_request and return
      end
    end
  
    private
  
    def general_attendee_params
      params.require(:UIN).permit(:UIN)
    end
end