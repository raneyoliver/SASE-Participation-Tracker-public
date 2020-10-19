# Helper functions for forms controller
module FormsHelper
  # returns an array of form ids
  def serialize_form(form)
    form.as_json(
      only: [:id, :event_id, :form_type, :questions, :time_restricted],
      include: {
        event: {
          only: [:name, :description, :event_type],
        },
      }
    )
  end

  def is_valid(form)
    if form.form_type == 'sign-in' && DateTime.now >= form.start_time && DateTime.now <= form.end_time
      return true
    end
    if form.form_type == 'RSVP' && DateTime.now < form.start_time
      return true
    end

    return false
  end

end
