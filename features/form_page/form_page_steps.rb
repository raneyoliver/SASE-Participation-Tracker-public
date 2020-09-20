When 'I go to the form page' do
  visit '/form/1'
end

Then 'I enter my UIN on the form page' do
  fill_in('form-UIN', with: '333333333')
end

Then 'I enter a too short UIN on the form page' do
  fill_in('form-UIN', with: '33333333')
end

Then 'I enter a too long UIN on the form page' do
  fill_in('form-UIN', with: '3333333333')
end

Then 'I try to enter non-numerical characters as a UIN on the form page' do
  fill_in('form-UIN', with: 'abcde!@#?')
end

Then "The UIN field doesn't accept the non-numerical characters on the form page" do
  expect(page).to have_field('form-UIN', with: '')
end

Then 'I can click the form submit button on the form page' do
  expect(page).to have_button('submit', disabled: false)
end

Then "I can't click the form submit button on the form page" do
  expect(page).to have_button('submit', disabled: true)
end
