Before '@event' do
  Event.new(
    id: 1,
    name: 'test event name',
    description: 'test event description',
    start_time: 'Thu, 1 Jan 1970 01:00:00 +0000',
    end_time: 'Thu, 1 Jan 1970 02:00:00 +0000'
  ).save
end

Then 'I go back to the edit event page' do
  visit '/edit_event/1'
end

Then 'I update the form' do
  fill_in('event-name', with: 'update this event name')
  fill_in('event-description', with: 'update this event description')
end

Then 'I can click the update button' do
  expect(page).to have_button('submit', disabled: false)
end

Then 'I remove the prefilled name' do
  fill_in('event-name', with: '')
  fill_in('event-description', with: 'update this event description')
end

Then "I can't click the update button" do
  expect(page).to have_button('submit', disabled: true)
end
