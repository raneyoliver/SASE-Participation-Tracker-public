Feature: Create Event Button
  As an admin
  I want a "Create Event" button on the main page
  So I can create events easily

@javascript
Scenario: Unauthenticated requests are redirected to the view events page
  When I go to the create event page
  Then I get redirected to the log in page

@javascript
@authRequired
Scenario: User is taken to the create event page
  When I go to the homepage
  Then I log in
  Then I click the create event button
  Then I should be taken to the create event page
