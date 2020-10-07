Feature: Create Event page
  As an admin
  I want to be able to fill out an event form
  So that I can create an event

# Note: capybara can't actually send POST requests, so this doesn't test /api/events/create
@javascript
@authRequired
Scenario: Submit button is clickable when the form is filled out
  When I go to the create event page
  Then I log in
  Then I go back to the create event page
  Then I fill out the form
  Then I can click the submit button

@javascript
@authRequired
Scenario: Submit button is not clickable when the form is missing a name
  When I go to the create event page
  Then I log in
  Then I go back to the create event page
  Then I fill out the form without a name
  Then I can't click the submit button

@javascript
@authRequired
Scenario: Submit button is clickable when the form is missing a description
  When I go to the create event page
  Then I log in
  Then I go back to the create event page
  Then I fill out the form without a description
  Then I can click the submit button on the create event page

@javascript
@authRequired
Scenario: Submit button is not clickable when the create RSVP form checkbox is not checked
  When I go to the create event page
  Then I log in
  Then I go back to the create event page
  Then I fill out the form without checking the RSVP form box
  Then I can click the submit button on the create event page
