Feature: View Events Page
As a member,
I want to be able to view Events,
so that I know what events are coming up

@javascript
Scenario: Navigating to the homepage without authenticating redirects to the view events Page
  When I go to the homepage
  Then I get redirected to the view events page

@javascript
Scenario: The view events page contains a log in button that redirects to the login page
  When I go to the view events page
  Then I click the log in button
  Then I get redirected to the log in page

@javascript
@event-date-filtering
Scenario: The view events page contains events
  When I go to the view events page
  Then I go to the event list
  Then I click the all events filter
  Then I can see all events
