Then 'I receive an alert about the user already existing' do
  expect(page).to have_content('User Creation Error')
end

Then 'I click ok on the alert on the new user page' do
  click_button('ok')
end

Then 'I remain on the new user page' do
  expect(page).to have_current_path('/form/de12b1128f3/new_user/333333333')
end
