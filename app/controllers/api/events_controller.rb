# Controller for api functionality related to events
class Api::EventsController < ApplicationController
#before_action :authenticate_api_admin!

  def list
    @events = Event.all.select('id, name, description, start_time, end_time')
    render json: @events
  end

  def create
    helpers.get_auth
    begin
      # Attempt to parse start and end date and respond with 400 if invalid
      # Ruby doesn't actually make sure dates are valid before you make a model with them
      DateTime.parse(params[:event][:start_time])
      DateTime.parse(params[:event][:end_time])
    rescue ArgumentError, NoMethodError
      head :bad_request and return
    end
    @event = Event.new(event_params)

    @event.save
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time)
  end
end
