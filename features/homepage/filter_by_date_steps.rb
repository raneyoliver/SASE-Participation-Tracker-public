Before '@event-date-filtering' do
  @time_in_past = 1.days.ago
  @time_in_future = 1.days.from_now
  Event.new(
    name: 'caveman meetup',
    start_time: @time_in_past,
    end_time: @time_in_past,
    event_type: 'Socials'
  ).save

  Event.new(
    name: 'paint the world chrome',
    start_time: @time_in_future,
    end_time: @time_in_future,
    event_type: 'Socials'
  ).save
end

Then 'I can see all events' do
  @event_cards = page.all('[id^="event-card-"]')
  expect(@event_cards.length).to be(2)
end

Then 'I click the all events filter' do
  click_on 'All'
end

Then 'I click the past events filter' do
  click_on 'Past'
end

Then 'I can only see events in the past' do
  @event_cards = page.all('[id^="event-card-"]')
  expect(@event_cards.length).to be(1)
  expect(@event_cards[0]).to have_text('caveman meetup')
end

Then 'I can only see events in the future' do
  @event_cards = page.all('[id^="event-card-"]')
  expect(@event_cards.length).to be(1)
  expect(@event_cards[0]).to have_text('paint the world chrome')
end
