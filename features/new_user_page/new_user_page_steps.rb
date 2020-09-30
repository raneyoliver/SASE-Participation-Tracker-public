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

Then 'I select my graduation year on the new user page' do
  select('2021', from: 'new-user-graduation-year')
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
