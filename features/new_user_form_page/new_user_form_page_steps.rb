When 'I go to the new user form page' do
  visit '/form/1/new_user'
end

Then 'I enter my UIN on the new user form page' do
  fill_in('new-user-UIN', with: '333333333')
end

Then 'I enter a too short UIN on the new user form page' do
  fill_in('new-user-UIN', with: '33333333')
end

Then 'I enter a too long UIN on the new user form page' do
  fill_in('new-user-UIN', with: '3333333333')
end

Then 'I try to enter non-numerical characters as a UIN on the new user form page' do
  fill_in('new-user-UIN', with: 'abcde!@#?')
end

Then "The UIN field doesn't accept the non-numerical characters on the new user form page" do
  expect(page).to have_field('new-user-UIN', with: '')
end

Then 'I enter my first name on the new user form page' do
  fill_in('new-user-first-name', with: 'New')
end

Then 'I enter my last name on the new user form page' do
  fill_in('new-user-last-name', with: 'User')
end

Then 'I enter my major on the new user form page' do
  fill_in('new-user-major', with: 'computer science')
end

Then 'I enter my graduation year on the new user form page' do
  fill_in('new-user-graduation-year', with: 2021)
end

Then 'I enter a too short graduation year on the new user form page' do
  fill_in('new-user-graduation-year', with: 202)
end

Then 'I enter a too long graduation year on the new user form page' do
  fill_in('new-user-graduation-year', with: 20_211)
end

Then 'I try to enter non-numerical characters as a graduation year on the new user form page' do
  fill_in('new-user-graduation-year', with: 'abcde!@#?')
end

Then "The graduation year field doesn't accept the non-numerical characters on the new user form page" do
  expect(page).to have_field('new-user-graduation-year', with: '')
end

Then 'I enter my email on the new user form page' do
  fill_in('new-user-email', with: 'address@domain.com')
end

Then 'I enter my phone number on the new user form page' do
  fill_in('new-user-phone-number', with: '333-333-3333')
end

Then 'I can click the form submit button on the new user form page' do
  expect(page).to have_button('submit', disabled: false)
end

Then "I can't click the form submit button on the new user form page" do
  expect(page).to have_button('submit', disabled: true)
end
