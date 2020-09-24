Before('@formRequired') do
  event_data = { id: 1, name: 'Test Event', description: 'description',
                 start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
  Event.create(event_data)
  form_data = { id: 'de12b1128f3', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                end_time: '2020-09-15T00:00:00.000Z', form_type: 'sign-in', questions: '[]' }
  Form.create(form_data)
end

Before('@authRequired') do
  auth_data = { username: 'Admin', password: 'U4xBFhCzDnmYq4bG' }
end
