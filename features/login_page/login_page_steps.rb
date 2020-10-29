When 'I go to the log in page' do
  visit('/login')
end

Then 'I get redirected to the log in page' do
  expect(page).to have_current_path('/login')
end

Then 'I only enter a password' do
  fill_in('password', with: 'test')
end

Then 'I am unable to log in' do
  expect(page).to have_current_path('/login')
end

Then 'I only enter a username' do
  fill_in('username', with: 'test')
end

Then 'I enter the wrong credentials' do
  fill_in('username', with: 'test')
  fill_in('password', with: 'test')
end

Then 'I click the log in button to log in' do
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

Then 'I am unable to click the log in button' do
  expect(page).to have_button('login', disabled: true)
end

Then 'I am able to click the log in button' do
  expect(page).to have_button('login', disabled: false)
end

Then 'An error message displays' do
  expect(page).to have_text('Error: Invalid Login')
end

Then 'The log in tooltip is displayed' do
  expect(page).to have_css('span[title="Fill in all fields to log in."]')
end

Then 'The log in tooltip is not displayed' do
  expect(page).to have_css('span[title=""]')
end
