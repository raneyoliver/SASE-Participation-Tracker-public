# Create single event and form so that calendar event can render
Before '@calendarEventDetails' do
  Event.new(
    id: 1,
    name: 'test event name',
    description: 'test event description',
    start_time: DateTime.now,
    end_time: DateTime.now + (1 / 24.0),
    event_type: 'Socials'
  ).save
  Form.new(
    id: 'de12b1128f3',
    event_id: 1,
    form_type: 'sign-in'
  ).save
end

Then 'I cannot see the event description' do
  expect(page).not_to have_content('test event description')
end

Then 'I cannot see the event type' do
  expect(page).not_to have_content('Socials')
end

Then 'I cannot see the event start datetime' do
  expect(page).not_to have_content(DateTime.now.strftime('%m/%d/%Y'))
end

Then 'I cannot see the event end datetime' do
  expect(page).not_to have_content((DateTime.now + (1 / 24.0)).strftime('%m/%d/%Y'))
end

Then 'I cannot see the event sign-in form link' do
  expect(page).not_to have_content('de12b1128f3')
end

Then 'I cannot see an event menu button' do
  expect(page).not_to have_selector('#event-menu-button')
end

Then 'I click on the event chip' do
  find('span', text: 'test event name').click
end

Then 'I can see the event description' do
  expect(page).to have_content('test event description')
end

Then 'I can see the event type' do
  expect(page).to have_content('Socials')
end

Then 'I can see the event start datetime' do
  expect(page).to have_content(DateTime.now.strftime('%m/%d/%Y'))
end

Then 'I can see the event end datetime' do
  expect(page).to have_content((DateTime.now + (1 / 24.0)).strftime('%m/%d/%Y'))
end

Then 'I can see the event sign-in form link' do
  expect(page).to have_content('de12b1128f3')
end
