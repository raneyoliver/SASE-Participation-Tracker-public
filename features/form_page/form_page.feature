Feature: Form page
As a member,
I want to fill out a sign-in form
so my attendance is recorded.

@formRequired
Scenario: Submit button is clickable when the UIN is entered correctly
  When I go to the form page
  Then I enter my UIN on the form page
  Then I can click the form submit button on the form page

@formRequired
Scenario: Submit button is not clickable when the UIN is too short
  When I go to the form page
  Then I enter a too short UIN on the form page
  Then I can't click the form submit button on the form page

@formRequired
Scenario: The UIN does not update after reaching its maximum length
  When I go to the form page
  Then I try to enter a too long UIN on the form page
  Then the UIN field doesn't accept characters from the too long UIN after its maximum length

@formRequired
Scenario: The UIN does not update when non-numerical characters are entered
  When I go to the form page
  Then I try to enter non-numerical characters as a UIN on the form page
  Then the UIN field doesn't accept the non-numerical characters on the form page

Scenario: The form page redirects to an error page if the form id is invalid
  When I go the the form page with an invalid form id
  Then I am redirected to an error page from the form page
