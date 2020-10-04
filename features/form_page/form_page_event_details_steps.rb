When 'I go to the form page to see event details' do
  visit '/form/de12b1128f3'
end

Then 'I see the event type related to the form' do
  expect(page).to have_content('GBM')
end

Then 'I see the event description related to the form' do
  expect(page).to have_content('description')
end
