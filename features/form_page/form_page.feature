Feature: Form page
As a member,
I want to fill out a sign-in form
so my attendance is recorded.

Scenario: Submit button is clickable when the UIN is entered correctly
  When I go to the form page
  Then I enter my UIN on the form page
  Then I can click the form submit button on the form page

Scenario: Submit button is not clickable when the UIN is too short
  When I go to the form page
  Then I enter a too short UIN on the form page
  Then I can't click the form submit button on the form page

Scenario: Submit button is not clickable when the UIN is too long
  When I go to the form page
  Then I enter a too long UIN on the form page
  Then I can't click the form submit button on the form page

Scenario: The UIN does not update when non-numerical characters are entered
  When I go to the form page
  Then I try to enter non-numerical characters as a UIN on the form page
  Then The UIN field doesn't accept the non-numerical characters on the form page