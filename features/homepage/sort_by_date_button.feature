Feature: Sort By Date Button
  As an admin
  I want a "Sort By Date" button on the page for events
  So I can see what events are coming up soon

@javascript
Scenario: Unauthenticated requests are redirected to the login page
  When I go to the homepage
  Then I get redirected to the view events page

@event-sorting
@javascript
@authRequired
Scenario: Event cards are sorted chronologically by default
  When I go to the homepage
  Then I log in
  Then I go to the event list
  Then I click the all events filter
  Then events should be sorted chronologically

@event-sorting
@javascript
@authRequired
Scenario: Event cards are sorted reverse-chronologically after clicking sort by date
  When I go to the homepage
  Then I log in
  Then I go to the event list
  Then I click the all events filter
  Then I click sort by date
  Then events should be sorted reverse-chronologically

@event-sorting
@javascript
@authRequired
Scenario: Event cards are sorted by id after clicking sort by date twice
  When I go to the homepage
  Then I log in
  Then I go to the event list
  Then I click the all events filter
  Then I click sort by date
  Then I click sort by date
  Then events should be sorted by id
