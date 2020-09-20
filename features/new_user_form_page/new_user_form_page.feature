Feature: New User Form page
As a member,
I want to fill out a sign-in form
so my attendance is recorded.

Scenario: Submit button is clickable when all fields are filled correctly
  When I go to the new user form page
  Then I enter my UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my major on the new user form page
  Then I enter my graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I enter my phone number on the new user form page
  Then I can click the form submit button on the new user form page

Scenario: Submit button is not clickable when the UIN is too short
  When I go to the new user form page
  Then I enter a too short UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my major on the new user form page
  Then I enter my graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I enter my phone number on the new user form page
  Then I can't click the form submit button on the new user form page

Scenario: Submit button is not clickable when the UIN is too long
  When I go to the new user form page
  Then I enter a too long UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my major on the new user form page
  Then I enter my graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I enter my phone number on the new user form page
  Then I can't click the form submit button on the new user form page

Scenario: The UIN does not update when non-numerical characters are entered
  When I go to the new user form page
  Then I try to enter non-numerical characters as a UIN on the new user form page
  Then The UIN field doesn't accept the non-numerical characters on the new user form page

Scenario: Submit button is not clickable when the first name is blank
  When I go to the new user form page
  Then I enter my UIN on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my major on the new user form page
  Then I enter my graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I enter my phone number on the new user form page
  Then I can't click the form submit button on the new user form page

Scenario: Submit button is not clickable when the last name is blank
  When I go to the new user form page
  Then I enter my UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my major on the new user form page
  Then I enter my graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I enter my phone number on the new user form page
  Then I can't click the form submit button on the new user form page

Scenario: Submit button is not clickable when the major is blank
  When I go to the new user form page
  Then I enter my UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I enter my phone number on the new user form page
  Then I can't click the form submit button on the new user form page

Scenario: Submit button is not clickable when the graduation year is too short
  When I go to the new user form page
  Then I enter my UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my major on the new user form page
  Then I enter a too short graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I enter my phone number on the new user form page
  Then I can't click the form submit button on the new user form page

Scenario: Submit button is not clickable when the graduation year is too long
  When I go to the new user form page
  Then I enter my UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my major on the new user form page
  Then I enter a too long graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I enter my phone number on the new user form page
  Then I can't click the form submit button on the new user form page

Scenario: The graduation year does not update when non-numerical characters are entered
  When I go to the new user form page
  Then I try to enter non-numerical characters as a graduation year on the new user form page
  Then The graduation year field doesn't accept the non-numerical characters on the new user form page

Scenario: Submit button is not clickable when the email is blank
  When I go to the new user form page
  Then I enter my UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my major on the new user form page
  Then I enter my graduation year on the new user form page
  Then I enter my phone number on the new user form page
  Then I can't click the form submit button on the new user form page

Scenario: Submit button is clickable when the phone number is blank
  When I go to the new user form page
  Then I enter my UIN on the new user form page
  Then I enter my first name on the new user form page
  Then I enter my last name on the new user form page
  Then I enter my major on the new user form page
  Then I enter my graduation year on the new user form page
  Then I enter my email on the new user form page
  Then I can click the form submit button on the new user form page