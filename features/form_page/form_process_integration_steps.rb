Then 'I click the form submit button on the form page' do
  click_button('submit')
end

Then 'I click the form submit button on the new user page' do
  click_button('submit')
end

Then 'I navigate to the new user page' do
  expect(page).to have_current_path('/form/de12b1128f3/new_user/333333333')
end

Then 'I navigate to the confirm submission page' do
  expect(page).to have_current_path('/form/confirm_submission')
end
