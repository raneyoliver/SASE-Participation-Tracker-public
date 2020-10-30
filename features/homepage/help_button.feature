Feature: Help Button
  As an admin
  I want a "Help" button on the main page
  So I can understand how to navigate the website

@authRequired
@javascript
Scenario: clicking the help button on the homepage redirects to the help page
When I go to the homepage
Then I click the log in button
Then I fill out the log in form
Then I click the help button
Then I get redirected to the help page

@javascript
Scenario: clicking the help button on the view events homepage redirects to the help page
When I go to the homepage
Then I click the help button
Then I get redirected to the help page
