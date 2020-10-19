Feature: Calendar View
As a user,
I want to be able to see a calendar view for events
so that I can easily see what time each event is.

@javascript
@calendarView
@authRequired
Scenario: Homepage renders a calendar view of the current month on page load
  When I go to the homepage
  Then I log in
  Then I can see a dropdown with the current year and month selected

@javascript
@calendarView
@authRequired
Scenario: Calendar shows the time and name of events for the current month
  When I go to the homepage
  Then I log in
  Then I can see the event for the current month
  Then I can't see the event that happened 2 months ago
