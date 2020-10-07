Feature: Form repeated submission
As a user,
I want my information to be counted only once if I fill out the form more than once
so my attendance is accurate.

@formRequired
@userRequired
@formUserRequired
@javascript
Scenario: Filling out a form as a user that has already filled it out
  When I go to the form page
  Then I enter my UIN on the form page
  Then I click the form submit button on the form page
  Then I navigate to the confirm update page
