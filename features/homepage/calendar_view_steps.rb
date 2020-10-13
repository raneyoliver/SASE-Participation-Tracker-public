Before '@calendarView' do
  @two_months_ago = 2.months.ago
  @now = Date.today

  Event.new(
    name: 'overthrow the government',
    start_time: @two_months_ago,
    end_time: @two_months_ago,
    event_type: 'Socials'
  ).save

  Event.new(
    name: 'establish a dictatorship',
    start_time: @now,
    end_time: @now,
    event_type: 'Socials'
  ).save
end

Then 'I go to the event list' do
  click_button 'List'
end

Then 'I can see a dropdown with the current year and month selected' do
  @now = Date.today
  expect(page).to have_select('year-select')
  expect(page).to have_select('month-select')
end

Then 'I can see the event for the current month' do
  expect(page).to have_content('establish a dictatorship')
end

Then "I can't see the event that happened 2 months ago" do
  expect(page).not_to have_content('overthrow the government')
end
