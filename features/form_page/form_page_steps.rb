When 'I go to the form page' do
  visit '/form/1'
end

Then 'I enter my UIN' do
  fill_in('UIN', with: '333333333')
end

Then 'I can click the form submit button' do
  expect(page).to have_button('submit', disabled: false)
end

Then 'I enter a too short UIN' do
  fill_in('UIN', with: '33333333')
end

Then 'I enter a too long UIN' do
  fill_in('UIN', with: '3333333333')
end

Then "I can't click the form submit button" do
  expect(page).to have_button('submit', disabled: true)
end

Then 'I try to enter non-numerical characters as a UIN' do
  fill_in('UIN', with: 'abcde!@#?')
end

Then "The UIN field doesn't accept the non-numerical characters" do
  expect(page).to have_field('UIN', with: '')
end
