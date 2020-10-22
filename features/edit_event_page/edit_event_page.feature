Feature: Edit event button
  As an admin
  I want a "Edit Event" button on the main page
  So I can edit events easily

@javascript
Scenario: Unauthenticated requests are redirected to the login page
When I go to the homepage
Then I get redirected to the view events page

@event
@javascript
@authRequired
Scenario: Update button is clickable when the form is filled out
  When I go to the homepage
  Then I log in
  Then I go back to the edit event page
  Then I update the form
  Then I can click the update button

@event
@javascript
@authRequired
Scenario: Update button is not clickable when the form is missing a name
  When I go to the homepage
  Then I log in
  Then I go back to the edit event page
  Then I remove the prefilled name
  Then I can't click the update button
