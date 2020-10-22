Then 'I click the change password button' do
  click_on 'change-password'
end

Then 'I am redirected to the change password page' do
  expect(page).to have_current_path('/change_password')
end

Then 'The change password button is unclickable' do
  expect(page).to have_button('change-password', disabled: true)
end

Then 'I fill in the change password fields' do
  fill_in('password', with: '1234')
  fill_in('password-confirmation', with: '1234')
end

Then 'I can click the change password button' do
  expect(page).to have_button('change-password', disabled: false)
end

Then 'I enter the old credentials' do
  fill_in('username', with: 'Admin')
  fill_in('password', with: 'password')
  click_button 'login'
end

Then 'I go to the change password page directly' do
  visit('/change_password')
end

Then 'I log in with the new credentials' do
  visit('/login')
  fill_in('username', with: 'Admin')
  fill_in('password', with: '1234')
  click_button 'login'
end
