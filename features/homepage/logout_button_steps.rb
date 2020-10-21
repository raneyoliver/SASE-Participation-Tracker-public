Then 'I click the logout button' do
  click_on 'logout'
end
Then 'I attempt to access the homepage' do
  visit '/'
end
Then 'I am unable to access the homepage' do
  expect(page).to have_current_path('/view_events')
end
Then 'I attempt to access the create event page' do
  visit '/'
end
Then 'I am unable to access the create event page' do
  expect(page).to have_current_path('/login')
end
