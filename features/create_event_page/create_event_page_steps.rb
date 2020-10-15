When 'I go to the create event page' do
  visit '/create_event'
end

Then 'I go back to the create event page' do
  visit '/create_event'
end

Then 'I fill out the form' do
  fill_in('event-name', with: 'My cool event')
  fill_in('event-description', with: 'Event Description')
  find(:css, '#event-create-RSVP').set(true)
end

Then 'I can click the submit button' do
  expect(page).to have_button('submit', disabled: false)
end

Then 'I fill out the form without a name' do
  fill_in('event-description', with: 'Event Description')
  find(:css, '#event-create-RSVP').set(true)
end

Then 'I fill out the form without a description' do
  fill_in('event-name', with: 'My cool event')
  find(:css, '#event-create-RSVP').set(true)
end

Then 'I fill out the form without checking the RSVP form box' do
  fill_in('event-name', with: 'My cool event')
  fill_in('event-description', with: 'Event Description')
end

Then "I can't click the submit button" do
  expect(page).to have_button('submit', disabled: true)
end

Then 'I can click the submit button on the create event page' do
  expect(page).to have_button('submit', disabled: false)
end

Then 'I check the RSVP form box' do
  find(:css, '#event-create-RSVP').set(true)
end

Then 'I can click the RSVP time restriction toggle' do
  @rsvp = find(:css, '#rsvp', visible: :all)
  expect(@rsvp.disabled?).to eq(false)
end

Then 'I cannot click the RSVP time restriction toggle' do
  @rsvp = find(:css, '#rsvp', visible: :all)
  expect(@rsvp.disabled?).to eq(true)
end
