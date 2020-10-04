# Controller for api functionality related to events
class Api::EventsController < ApplicationController
  def list
    head :bad_request and return unless helpers.check_auth

    @events = Event.includes(forms: [:form_users]).select(:id, :name, :description, :start_time, :end_time)

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

  def edit
    @event = Event.find(params[:id])
    render json: @event
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  def update
    puts params
    @event = Event.find(params[:id])
    @event.update(event_params)
    head :bad_request and return unless @event.save
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  def delete
    @event = Event.find(params[:id])
    @event.destroy
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time)
  end
end
