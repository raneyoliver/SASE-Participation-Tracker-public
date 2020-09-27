When 'I go to the log in page' do
  visit('/login')
end

Then 'I get redirected to the log in page' do
  expect(page).to have_current_path('/login')
end

Then 'I only enter a password' do
  fill_in('password', with: 'test')
  click_button 'login'
end

Then 'I am unable to log in' do
  expect(page).to have_current_path('/login')
end

Then 'I only enter a username' do
  fill_in('username', with: 'test')
  click_button 'login'
end

Then 'I enter the wrong credentials' do
  fill_in('username', with: 'test')
  fill_in('password', with: 'test')
  click_button 'login'
end

Then 'I get redirected to the homepage' do
  expect(page).to have_current_path('/')
end

Then 'I enter the wrong password' do
  fill_in('username', with: 'testAdmin')
  fill_in('password', with: 'notThePassword')
  click_button 'login'
end
