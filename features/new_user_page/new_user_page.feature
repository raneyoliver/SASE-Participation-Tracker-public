Feature: New User page
As a member,
I want to fill out a sign-in form
so my attendance is recorded.

@formRequired
@javascript
Scenario: Submit button is clickable when all fields are filled correctly
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter my phone number on the new user page
  Then I can click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the first name is blank
  When I go to the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the last name is blank
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the major is blank
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the graduation year is not selected
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I enter my email on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the email is blank
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is clickable when the phone number is blank
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I can click the form submit button on the new user page

Scenario: The new user page redirects to an error page if the form id is invalid
  When I go the the new user page with an invalid form id
  Then I am redirected to an error page from the new user page

@formRequired
@javascript
Scenario: The new user page redirects to an error page if the UIN is too short
  When I go the the new user page with a too short UIN
  Then I am redirected to an error page from the new user page

@formRequired
@javascript
Scenario: The new user page redirects to an error page if the UIN is too long
  When I go the the new user page with a too long UIN
  Then I am redirected to an error page from the new user page

@formRequired
@javascript
Scenario: The new user page redirects to an error page if the UIN is non-numerical
  When I go the the new user page with a non-numerical UIN
  Then I am redirected to an error page from the new user page
