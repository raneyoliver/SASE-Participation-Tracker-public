When 'I go to the view events page' do
  visit '/view_events'
end

Then 'I click the log in button' do
  click_on 'login'
end

Then 'I am redirected to the view events page' do
  expect(page).to have_current_path('/view_events')
end
