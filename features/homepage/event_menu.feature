Feature: Event Menu Button
As an admin,
I want event cards to have a menu button in the top-right
so that I can perform actions like deleting, editing, and adding an RSVP form.

@javascript
Scenario: Unauthenticated requests are redirected to the login page
When I go to the homepage
Then I get redirected to the log in page

@javascript
@authRequired
Scenario: Event menu button does not exist when no events exist
  When I go to the homepage
  Then I log in
  Then I go to the event list
  Then I can not see an event menu button

@event-menu
@javascript
@authRequired
Scenario: Event menu button does exist when an event exists
  When I go to the homepage
  Then I log in
  Then I go to the event list
  Then I click the all events filter
  Then I can see an event menu button

@event-menu
@javascript
@authRequired
Scenario: Event menu button button expands to reveal an edit event button
  When I go to the homepage
  Then I log in
  Then I go to the event list
  Then I click the all events filter
  Then I click on the event menu button
  Then there is an edit event button
  Then I click the edit event button
  Then I should be taken to the edit event page

@event-menu
@javascript
@authRequired
Scenario: Event menu button button expands to reveal a delete event button
  When I go to the homepage
  Then I log in
  Then I go to the event list
  Then I click the all events filter
  Then I click on the event menu button
  Then there is a delete event button
  Then I click the delete event button
  Then a dialog confirmation box will appear with options yes or no

@event-menu
@javascript
@authRequired
Scenario: Event menu button button expands to reveal a create RSVP form button
  When I go to the homepage
  Then I log in
  Then I go to the event list
  Then I click the all events filter
  Then I click on the event menu button
  Then there is a create RSVP form button
