# Controller for api functionality related to events
class Api::EventsController < ApplicationController
  def list
    head :bad_request and return unless helpers.check_auth

    @events = Event.includes(forms: [:form_users])
                   .select(:id, :name, :description, :start_time, :end_time, :event_type)

    @response = @events.map do |event|
      helpers.serialize_event event
    end

    render json: @response.to_json
  end

  def create
    head :bad_request and return unless helpers.check_auth

    @event = Event.new(event_params)
    head :bad_request and return unless @event.save

    helpers.create_form_for_event(@event, 'sign-in')

    return unless params[:create_rsvp_form]

    helpers.create_form_for_event(@event, 'RSVP')
  end

  def export
    head :bad_request and return unless helpers.check_auth

    @records_array = Event.joins(forms: [{ form_users: [:user] }]).order(:id).select(
      :event_id,
      'event.name as event_name',
      :event_type,
      :form_id,
      :form_type,
      :user_id,
      :first_name,
      :last_name,
      :email,
      :phone_number
    )

    @response = @records_array.map do |event|
      event.as_json(
        except: :id
      )
    end

    render json:
      @response.to_json
  end

  def add_form
    head :bad_request and return unless helpers.check_auth

    @event = Event.find(params[:id])
    helpers.create_form_for_event(@event, params[:form_type])
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  def edit
    head :bad_request and return unless helpers.check_auth

    @event = Event.find(params[:id])
    render json: @event
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  def update
    head :bad_request and return unless helpers.check_auth

    @event = Event.find(params[:id])
    @event.update(event_params)
    head :bad_request and return unless @event.save
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  def delete
    head :bad_request and return unless helpers.check_auth

    @event = Event.find(params[:id])
    @event.destroy
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :event_type)
  end
end
