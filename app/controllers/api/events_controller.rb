# Controller for api functionality related to events
class Api::EventsController < ApplicationController
  def list
    head :bad_request and return unless helpers.check_auth

    @events = Event.includes(forms: [:form_users]).select(:id, :name, :description, :event_type, :start_time, :end_time)

    @response = @events.map do |event|
      helpers.serialize_event event
    end

    render json: @response.to_json
  end

  def create
    head :bad_request and return unless helpers.check_auth

    @event = Event.new(event_params)
    head :bad_request and return unless @event.save

    # Create sign-in form
    @form = Form.new(
      id: helpers.make_unique_id,
      event_id: @event.id,
      start_time: @event.start_time,
      end_time: @event.end_time,
      form_type: 'sign-in',
      questions: [].to_json
    )
    @form.save
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :event_type)
  end
end
