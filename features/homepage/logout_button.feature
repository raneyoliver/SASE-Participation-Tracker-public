Feature: Logout Button
  As an admin
  I want a "Log Out" button on the main page
  So I can maintain security when accessing the app

@event-sorting
@javascript
@authRequired
Scenario: clicking the login button logs the user out
When I go to the homepage
Then I log in
Then I click the logout button
Then I get redirected to the log in page
Then I attempt to access the homepage
Then I am unable to access the homepage
Then I attempt to access the create event page
Then I am unable to access the create event page
