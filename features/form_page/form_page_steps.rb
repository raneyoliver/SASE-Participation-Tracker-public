When 'I go to the form page' do
  visit '/form/de12b1128f3'
end

When 'I go the the form page with an invalid form id' do
  visit '/form/1'
end

Then 'I enter my UIN on the form page' do
  fill_in('form-UIN', with: '333333333')
end

Then 'I enter a too short UIN on the form page' do
  fill_in('form-UIN', with: '33333333')
end

Then 'I try to enter a too long UIN on the form page' do
  fill_in('form-UIN', with: '3333333333')
end

Then "the UIN field doesn't accept characters from the too long UIN after its maximum length" do
  expect(page).to have_field('form-UIN', with: '333333333')
end

Then 'I try to enter non-numerical characters as a UIN on the form page' do
  fill_in('form-UIN', with: 'abcde!@#?')
end

Then "the UIN field doesn't accept the non-numerical characters on the form page" do
  expect(page).to have_field('form-UIN', with: '')
end

Then 'I can click the form submit button on the form page' do
  expect(page).to have_button('submit', disabled: false)
end

Then "I can't click the form submit button on the form page" do
  expect(page).to have_button('submit', disabled: true)
end

Then 'The form submit tooltip is displayed' do
  expect(page).to have_css('span[title="Fill in all fields to submit."]')
end

Then 'The form submit tooltip is not displayed' do
  expect(page).to have_css('span[title=""]')
end

Then 'I am redirected to an error page from the form page' do
  expect(page).to have_current_path('/form/error')
end
