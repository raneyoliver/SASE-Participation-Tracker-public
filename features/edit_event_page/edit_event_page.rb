Before '@event' do
  Event.new(
    id: 1,
    name: 'test event name',
    description: 'test event description',
    start_time: 'Thu, 1 Jan 1970 01:00:00 +0000',
    end_time: 'Thu, 1 Jan 1970 02:00:00 +0000',
    event_type: 'Socials'
  ).save
end

Before '@sign_in_form' do
  Form.new(
    id: '8888888888',
    event_id: 1,
    form_type: 'sign-in',
    time_restricted: true
  ).save
end

Before '@rsvp_form' do
  Form.new(
    id: '8888888889',
    event_id: 1,
    form_type: 'RSVP',
    time_restricted: true
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

Then 'The update event tooltip is displayed' do
  expect(page).to have_css('span[title="Fill in all fields in red to update event."]')
end

Then 'The update event tooltip is not displayed' do
  expect(page).to have_css('span[title=""]')
end

Then 'I remove the prefilled name' do
  fill_in('event-name', with: '')
  fill_in('event-description', with: 'update this event description')
end

Then "I can't click the update button" do
  expect(page).to have_button('submit', disabled: true)
end

Then 'the switches show previous restriction settings' do
  @sign_in = find(:css, '#sign_in', visible: :all)
  @rsvp = find(:css, '#rsvp', visible: :all)
  expect(@sign_in.checked?).to eq(true)
  expect(@rsvp.checked?).to eq(true)
end
