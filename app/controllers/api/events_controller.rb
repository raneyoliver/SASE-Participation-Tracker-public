# Controller for api functionality related to events
class Api::EventsController < ApplicationController
  def list
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

    helpers.create_form_for_event(@event, 'sign-in', params[:sign_in_restricted])

    return unless params[:create_rsvp_form]

    helpers.create_form_for_event(@event, 'RSVP', params[:rsvp_restricted])
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
    helpers.create_form_for_event(@event, params[:form_type], params[:time_restricted])
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  def edit
    head :bad_request and return unless helpers.check_auth

    @records = Event.joins(:forms).order(:id).select(
      :id, :name, :description, :start_time, :end_time,
      :event_type
    ).find(params[:id])

    @response = @records.as_json(
      include: {
        forms: {
          only: [:id, :form_type, :time_restricted],
        },
      }
    )

    render json: @response
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  def update
    head :bad_request and return unless helpers.check_auth

    @event = Event.find(params[:id])
    @event.update(event_params)

    # Change form restrictions
    @sign_in_form = Form.where(event_id: params[:id], form_type: 'sign-in')
    @rsvp_form = Form.where(event_id: params[:id], form_type: 'RSVP')
    @sign_in_form.update(time_restricted: params.fetch(:sign_in_restricted))
    @rsvp_form.update(time_restricted: params.fetch(:rsvp_restricted))

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
