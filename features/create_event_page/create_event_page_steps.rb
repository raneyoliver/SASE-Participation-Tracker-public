When 'I go to the create event page' do
  visit '/create_event'
end

Then 'I go back to the create event page' do
  visit '/create_event'
end

Then 'I fill out the form' do
  fill_in('event-name', with: 'My cool event')
  fill_in('event-description', with: 'Event Description')
  # Start and end time are automatically filled relative to current date
end

Then 'I can click the submit button' do
  expect(page).to have_button('submit', disabled: false)
end

Then 'I fill out the form without a name' do
  fill_in('event-description', with: 'Event Description')
  # Start and end time are automatically filled relative to current date
end

Then "I can't click the submit button" do
  expect(page).to have_button('submit', disabled: true)
end
