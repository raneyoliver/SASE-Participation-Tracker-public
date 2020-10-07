Feature: Filter By Event Type Buttons
  As an admin
  I want buttons to filter by event type
  So that it's easier to find the events I'm looking for

@eventTypeFiltering
@javascript
@authRequired
Scenario: You can see all event types by default
  When I go to the homepage
  Then I log in
  Then I can see all events

@eventTypeFiltering
@javascript
@authRequired
Scenario: You can only see social events after clicking the Socials filter
  When I go to the homepage
  Then I log in
  Then I click the Socials filter
  Then I can only see social events

@eventTypeFiltering
@javascript
@authRequired
Scenario: You can only see GBM events after clicking the GBM filter
  When I go to the homepage
  Then I log in
  Then I click the GBM filter
  Then I can only see GBM events
