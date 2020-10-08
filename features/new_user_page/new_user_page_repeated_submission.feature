Feature: New user repeated submission
As a user,
I want my information to be counted only once if I fill out the form more than once
so my attendance is accurate.

@formRequired
@userRequired
@javascript
Scenario: Filling out the new user page as a user that already exists
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter my phone number on the new user page
  Then I click the form submit button on the new user page
  Then I receive an alert about the user already existing
  Then I click ok on the alert on the new user page
  Then I remain on the new user page
