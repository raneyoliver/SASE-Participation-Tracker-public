When 'I go to the new user page' do
  visit '/form/de12b1128f3/new_user/333333333'
end

When 'I go the the new user page with an invalid form id' do
  visit '/form/1/new_user/333333333'
end

When 'I go the the new user page with a too short UIN' do
  visit '/form/1/new_user/33333333'
end

When 'I go the the new user page with a too long UIN' do
  visit '/form/1/new_user/3333333333'
end

When 'I go the the new user page with a non-numerical UIN' do
  visit '/form/1/new_user/afcde!@#$'
end

Then 'I enter my first name on the new user page' do
  fill_in('new-user-first-name', with: 'New')
end

Then 'I enter my last name on the new user page' do
  fill_in('new-user-last-name', with: 'User')
end

Then 'I enter my major on the new user page' do
  fill_in('new-user-major', with: 'computer science')
end

Then 'I enter my graduation year on the new user page' do
  fill_in('new-user-graduation-year', with: 2021)
end

Then 'I enter a too short graduation year on the new user page' do
  fill_in('new-user-graduation-year', with: 202)
end

Then 'I try to enter a too long graduation year on the new user page' do
  fill_in('new-user-graduation-year', with: 20_211)
end

Then "the graduation field doesn't accept characters from the too long graduation year after its maximum length" do
  expect(page).to have_field('new-user-graduation-year', with: 2021)
end

Then 'I try to enter non-numerical characters as a graduation year on the new user page' do
  fill_in('new-user-graduation-year', with: 'abcde!@#?')
end

Then "the graduation year field doesn't accept the non-numerical characters on the new user page" do
  expect(page).to have_field('new-user-graduation-year', with: '')
end

Then 'I enter my email on the new user page' do
  fill_in('new-user-email', with: 'address@domain.com')
end

Then 'I enter my phone number on the new user page' do
  fill_in('new-user-phone-number', with: '333-333-3333')
end

Then 'I can click the form submit button on the new user page' do
  expect(page).to have_button('submit', disabled: false)
end

Then "I can't click the form submit button on the new user page" do
  expect(page).to have_button('submit', disabled: true)
end

Then 'I am redirected to an error page from the new user page' do
  expect(page).to have_current_path('/form/error')
end
