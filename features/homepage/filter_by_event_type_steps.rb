Before '@eventTypeFiltering' do
  @now = Time.now
  Event.new(
    name: 'cool social',
    start_time: @now,
    end_time: @now,
    event_type: 'Socials'
  ).save
  Event.new(
    name: 'wicked gbm (whatever the hell that means)',
    start_time: @now,
    end_time: @now,
    event_type: 'GBM'
  ).save
end

Then 'I click the Socials filter' do
  click_button 'Socials'
end

Then 'I click the GBM filter' do
  click_button 'GBM'
end

Then 'I can only see social events' do
  @event_cards = page.all('[id^="event-card-"]')
  expect(@event_cards.length).to be(1)
  expect(@event_cards[0]).to have_text('Socials')
end

Then 'I can only see GBM events' do
  @event_cards = page.all('[id^="event-card-"]')
  expect(@event_cards.length).to be(1)
  expect(@event_cards[0]).to have_text('GBM')
end
