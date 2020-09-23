AfterConfiguration do
  # use a run-once hook to initialize test database
  # puts 'in after configuration'
  # puts "RAILS_ENV: #{Rails.env}"

  # event_data = { id: 1, name: 'Test Event', description: 'description',
  # start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z'}
  # Event.create(event_data)
  # puts Event.first.id
  # form_data = { id: 'de12b1128f3', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
  # end_time: '2020-09-15T00:00:00.000Z', form_type: 'sign-in', questions: '[]'}
  # Form.create(form_data)
  # puts Form.first.id
end

Before('@formRequired') do |_test|
  event_data = { id: 1, name: 'Test Event', description: 'description',
                 start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
  Event.create(event_data)
  form_data = { id: 'de12b1128f3', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                end_time: '2020-09-15T00:00:00.000Z', form_type: 'sign-in', questions: '[]'}
  Form.create(form_data)
end

After('@formRequired') do |_test|
  Event.destroy_all
  Form.destroy_all
end
