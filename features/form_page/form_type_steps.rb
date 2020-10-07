When 'I go to the form page to see form types' do
  visit '/form/de12b1128f3'
end

Then 'I see that the form is a sign-in form' do
  expect(page).to have_content('Sign-in Form')
end

Then 'I see that the form is an RSVP form' do
  expect(page).to have_content('RSVP Form')
end
