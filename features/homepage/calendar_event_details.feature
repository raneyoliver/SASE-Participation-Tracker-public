Feature: Calendar Event Details
As an admin,
I want to click on an event in the calendar and see the event's details in a popup window
so I can find event details without cluttering the calendar.

@javascript
Scenario: Unauthenticated requests are redirected to the login page
When I go to the homepage
Then I get redirected to the view events page

@javascript
@authRequired
@calendarEventDetails
Scenario: Event details are not visible when the event chip has not been clicked
  When I go to the homepage
  Then I log in
  Then I cannot see the event description
  Then I cannot see the event type
  Then I cannot see the event start datetime
  Then I cannot see the event end datetime
  Then I cannot see the event sign-in form link
  Then I cannot see an event menu button

@javascript
@authRequired
@calendarEventDetails
Scenario: Event details are visible when the event chip has been clicked
  When I go to the homepage
  Then I log in
  Then I click on the event chip
  Then I can see the event description
  Then I can see the event type
  Then I can see the event start datetime
  Then I can see the event end datetime
  Then I can see the event sign-in form link
  Then I can see an event menu button
