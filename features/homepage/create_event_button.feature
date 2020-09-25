Feature: Create Event Button
  As an admin
  I want a "Create Event" button on the main page
  So I can create events easily

@javascript
@authRequired
Scenario: User is taken to the create event page
  When I go to the homepage
  Then I log in
  Then I click the create event button
  Then I should be taken to the create event page
