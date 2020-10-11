Feature: Log In
  As an admin
  I want my application to be protected from unauthenticated requests
  So only I can access the application

@javascript
Scenario: I cannot access the homepage without logging in
  When I go to the homepage
  Then I get redirected to the log in page

@javascript
@authRequired
Scenario: Entering valid credentials takes me to the homepage
  When I go to the homepage
  Then I get redirected to the log in page
  Then I log in
  Then I get redirected to the homepage

@javascript
Scenario: I cannot log in without a username
  When I go to the log in page
  Then I only enter a password
  Then I am unable to click the log in button

@javascript
Scenario: I cannot log in without a password
  When I go to the log in page
  Then I only enter a username
  Then I am unable to click the log in button

@javascript
Scenario: I cannot log in with incorrect credentials, and an error message displays
  When I go to the log in page
  Then I enter the wrong credentials
  Then I am unable to log in
  Then An error message displays

@javascript
@authRequired
Scenario: I cannot log in with incorrect password
  When I go to the log in page
  Then I enter the wrong password
  Then I am unable to log in
