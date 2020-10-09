# Helper functions for events controller
module EventsHelper
  # returns an array of form ids
  def serialize_event(event)
    event.as_json(
      include: {
        forms: {
          only: [:id, :form_type],
          methods: :user_count,
        },
      }
    )
  end

  # returns an array of events with users who signed up. shows:
  # event:  id, name
  # form:   id, user count
  # user:   id, first_name, last_name, email, phone_number
  def serialize_export(event)
    event.as_json(
      include: {
        forms: {
          include: {
            form_users: {
              include: {
                user: {
                  except: [:created_at, :updated_at, :major, :graduation_year],
                },
              },
              except: [:id, :form_id, :user_id],
            },
          },
          except: [:event_id, :start_time, :end_time, :form_type, :questions],
          methods: :user_count,
        },
      }
    )
  end

  def make_unique_id
    # previous method
    # id = DateTime.now.strftime("%Y%m%d%k%M%S%L") # date in ms
    # return id.to_i.to_s(36)
    # return id.to_i(36)

    # unique id based on date, hexadecimal. Using first 10 characters only
    Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
  end

  def create_form_for_event(event, form_type)
    form = Form.new(
      id: make_unique_id,
      event_id: event.id,
      start_time: event.start_time,
      end_time: event.end_time,
      form_type: form_type,
      questions: [].to_json
    )
    form.save
  end
end
