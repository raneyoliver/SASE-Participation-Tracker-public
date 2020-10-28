Before('@formRequired') do
  event_data = { id: 1, name: 'Test Event', description: 'description',
                 start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z',
                 event_type: 'Socials' }
  Event.create(event_data)
  form_data = { id: 'de12b1128f3', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                end_time: '2020-09-15T00:00:00.000Z', form_type: 'sign-in', questions: '[]' }
  Form.create(form_data)
end

Before('@restrictedSignInFormRequired') do
  event_data = { id: 1, name: 'Test Event', description: 'description',
                 start_time: '1970-01-01T06:00:00.000Z', end_time: '1970-01-01T06:00:00.000Z',
                 event_type: 'Socials' }
  Event.create(event_data)
  form_data = { id: 'de12b1128f3', event_id: 1, start_time: '1970-01-01T06:00:00.000Z',
                end_time: '1970-01-01T06:00:00.000Z', form_type: 'sign-in', questions: '[]',
                time_restricted: true }
  Form.create(form_data)
end

Before('@restrictedRSVPFormRequired') do
  event_data = { id: 1, name: 'Test Event', description: 'description',
                 start_time: '1970-01-01T06:00:00.000Z', end_time: '1970-01-01T06:00:00.000Z',
                 event_type: 'Socials' }
  Event.create(event_data)
  form_data = { id: 'de12b1128f3', event_id: 1, start_time: '1970-01-01T06:00:00.000Z',
                end_time: '1970-01-01T06:00:00.000Z', form_type: 'RSVP', questions: '[]',
                time_restricted: true }
  Form.create(form_data)
end

Before('@userRequired') do
  user_data = { id: '95e229d8aca716874c8feca1501379e06f239d03', first_name: 'New', last_name: 'User',
                major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                phone_number: '3333333333' }
  User.create(user_data)
end

Before('@formUserRequired') do
  form_user_data = { form_id: 'de12b1128f3', user_id: '95e229d8aca716874c8feca1501379e06f239d03' }
  @form_user = FormUser.create(form_user_data)
end

Before('@RSVPFormRequired') do
  event_data = { id: 1, name: 'Test Event', description: 'description',
                 start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z',
                 event_type: 'Socials' }
  Event.create(event_data)
  form_data = { id: 'de12b1128f3', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                end_time: '2020-09-15T00:00:00.000Z', form_type: 'RSVP', questions: '[]' }
  Form.create(form_data)
end

Before('@authRequired') do
  @admin = Admin.new(username: 'Admin', password: 'password')
  @admin.save
end
