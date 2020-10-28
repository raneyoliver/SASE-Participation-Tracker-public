# Helper functions for forms controller
module FormsHelper
  # returns an array of form ids
  def serialize_form(form)
    form.as_json(
      only: [:id, :event_id, :form_type, :time_restricted],
      include: {
        event: {
          only: [:name, :description, :event_type],
        },
      }
    )
  end

  def form_valid?(form)
    @event = Event.find(form.event_id)
    if form.time_restricted == true
      return true if form.form_type == 'sign-in' && DateTime.now >= @event.start_time && DateTime.now <= @event.end_time
      return true if form.form_type == 'RSVP' && DateTime.now < @event.start_time

      # Restricted
      return false
    end

    true
  end
end
