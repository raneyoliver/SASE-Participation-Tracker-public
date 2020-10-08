# Create single event so that event card with menu can render
Before '@event-menu' do
  Event.new(
    id: 1,
    name: 'test event name',
    description: 'test event description',
    start_time: 'Thu, 1 Jan 1970 01:00:00 +0000',
    end_time: 'Thu, 1 Jan 1970 02:00:00 +0000',
    event_type: 'Socials'
  ).save
end

Then 'I can not see an event menu button' do
  expect(page).not_to have_selector('#event-menu-button')
end

Then 'I can see an event menu button' do
  expect(page).to have_selector('#event-menu-button')
end

Then 'I click on the event menu button' do
  click_on 'event-menu-button'
end

Then 'there is an edit event button' do
  expect(page).to have_content('Edit Event')
end

Then 'I click the edit event button' do
  find('li.MuiListItem-button', text: 'Edit Event').click
end

Then 'I should be taken to the edit event page' do
  expect(page).to have_current_path('/edit_event/1')
end

Then 'there is a delete event button' do
  expect(page).to have_content('Delete Event')
end

Then 'I click the delete event button' do
  find('li.MuiListItem-button', text: 'Delete Event').click
end

Then 'a dialog confirmation box will appear with options yes or no' do
  expect(page).to have_selector('#alert-dialog-title')
end

Then 'there is a create RSVP form button' do
  expect(page).to have_content('Create RSVP Form')
end
