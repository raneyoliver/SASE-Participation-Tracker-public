# Create single event so that event card with menu can render
Before '@event-menu' do
  Event.new(
    name: 'Test Event',
    start_time: 'Thu, 1 Jan 1970 01:00:00 +0000',
    end_time: 'Thu, 1 Jan 1970 02:00:00 +0000'
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

Then 'there is a delete event button' do
  expect(page).to have_content('Delete Event')
end
