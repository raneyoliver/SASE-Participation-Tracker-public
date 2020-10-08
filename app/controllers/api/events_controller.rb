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

    sql = "select
    e.id as event_id,
    e.name as event_name,
    e.event_type,
    e.start_time,
    e.end_time,
    f.id as form_id,
    f.form_type,
    u.*
    
    from public.user u 
    
    join form_user fu on 
      fu.user_id = u.id
      
    join form f on 
      f.id = fu.form_id
      
    join public.event e on 
      e.id = f.event_id"
    
    @records_array = ActiveRecord::Base.connection.execute(sql)
    # @users = User.joins(Event.where())
    
    render json: 
      @records_array.to_json
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :event_type)
  end
end
