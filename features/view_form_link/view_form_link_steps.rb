When 'I go to the homepage to view the form link' do
  visit '/'
end

Then 'I see the form id on the homepage' do
  expect(page).to have_content('de12b1128f3')
end

Then 'the form id links to the form page' do
  expect(page).to have_link(href: '/form/de12b1128f3')
end

Then 'I click the link' do
  click_link 'de12b1128f3'
end

Then 'I go to the form page from the home page' do
  expect(page).to have_current_path('/form/de12b1128f3')
end
