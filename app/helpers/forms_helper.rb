# Helper functions for forms controller
module FormsHelper
  # returns an array of form ids
  def serialize_form(form)
    form.as_json(
      only: [:id, :event_id, :form_type, :questions],
      include: {
        event: {
          only: [:name, :description, :event_type],
        },
      }
    )
  end
end
