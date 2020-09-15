# Controller for api functionality related to events
class Api::EventsController < ApplicationController
  def list
    @events = Event.find_each
    render json: @events
  end

  def create
    @event = Event.new(event_params)

    @event.save
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time)
  end
end
