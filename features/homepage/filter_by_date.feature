Feature: Filter By Date Buttons
  As an admin
  I want buttons to filter past, upcoming, and all events
  So that it's easier to find the events I'm looking for

@event-date-filtering
@javascript
@authRequired
Scenario: You can see all events by default
  When I go to the homepage
  Then I log in
  Then I can see all events

@event-date-filtering
@javascript
@authRequired
Scenario: You can only see past events after clicking past
  When I go to the homepage
  Then I log in
  Then I click the past events filter
  Then I can only see events in the past

@event-date-filtering
@javascript
@authRequired
Scenario: You can only see future events after clicking upcoming
  When I go to the homepage
  Then I log in
  Then I click the upcoming events filter
  Then I can only see events in the future
