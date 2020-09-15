When 'I go to the homepage' do
  visit '/'
end

Then 'I click the create event button' do
  click_button 'new-event'
end

Then 'I should be taken to the create event page' do
  expect(page).to have_current_path('/create_event')
end
