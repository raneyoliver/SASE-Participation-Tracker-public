Then 'I fill out the log in form' do
  fill_in('username', with: 'Admin')
  fill_in('password', with: 'password')
  click_button 'login'
end

Then 'I get redirected to the help page' do
  expect(page).to have_current_path('/help')
end

Then 'I click the help button' do
  click_on 'help'
end
