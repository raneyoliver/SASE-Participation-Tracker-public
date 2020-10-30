Feature: Help Button
  As an admin
  I want a "Help" button on the navbar
  So I can understand how to navigate the website

@javascript
Scenario: clicking the help button on the navbar redirects to the help page
When I go to the homepage
Then I click the help button
Then I get redirected to the help page
