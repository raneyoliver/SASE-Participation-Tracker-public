When 'I go to the homepage to view the form user count' do
  visit '/'
end

Then 'I see the form user count on the homepage' do
  expect(page).to have_content('(0 respondants)')
end
