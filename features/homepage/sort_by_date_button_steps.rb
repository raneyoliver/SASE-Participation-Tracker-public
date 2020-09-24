# Create event models so that event cards render
Before '@event-sorting' do
  Event.new(
    name: 'Second chronological event',
    start_time: 'Thu, 1 Jan 1970 01:00:00 +0000',
    end_time: 'Thu, 1 Jan 1970 02:00:00 +0000'
  ).save

  Event.new(
    name: 'First chronological event',
    start_time: 'Thu, 1 Jan 1970 00:00:00 +0000',
    end_time: 'Thu, 1 Jan 1970 01:00:00 +0000'
  ).save

  Event.new(
    name: 'Third chronological event',
    start_time: 'Thu, 1 Jan 1970 02:00:00 +0000',
    end_time: 'Thu, 1 Jan 1970 03:00:00 +0000'
  ).save
end

Then 'I click sort by date' do
  click_on 'sort-by-date'
end

Then 'events should be sorted by id' do
  @event_cards = page.all('[id^="event-card-"]')
  expect(@event_cards[0]).to have_text('Second chronological event')
  expect(@event_cards[1]).to have_text('First chronological event')
  expect(@event_cards[2]).to have_text('Third chronological event')
end

Then 'events should be sorted chronologically' do
  @event_cards = page.all('[id^="event-card-"]')
  expect(@event_cards[0]).to have_text('First chronological event')
  expect(@event_cards[1]).to have_text('Second chronological event')
  expect(@event_cards[2]).to have_text('Third chronological event')
end

Then 'events should be sorted reverse-chronologically' do
  @event_cards = page.all('[id^="event-card-"]')
  expect(@event_cards[0]).to have_text('Third chronological event')
  expect(@event_cards[1]).to have_text('Second chronological event')
  expect(@event_cards[2]).to have_text('First chronological event')
end
