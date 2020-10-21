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
  Then I enter my email again on the new user page
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
  Then I enter my email again on the new user page
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
  Then I enter my email again on the new user page
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
  Then I enter my email again on the new user page
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
  Then I enter my email again on the new user page
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
Scenario: Submit button is not clickable when the email is missing both an @ followed by a dot symbol
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter an email without @ followed by dot in it on the new user page
  Then I enter an email without @ followed by dot in it again on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the email is missing an @ symbol
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email missing an @ symbol on the new user page
  Then I enter my email missing an @ symbol again on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the email is missing a dot symbol followed by the @
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email missing a dot symbol after the @ on the new user page
  Then I enter my email missing a dot symbol after the @ again on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the email confirmation does not match email
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter a non matching email on the new user page
  Then I enter my phone number on the new user page
  Then I can't click the form submit button on the new user page

@formRequired
@javascript
Scenario: Submit button is not clickable when the phone number is invalid and not blank
  When I go to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter my email again on the new user page
  Then I enter an invalid phone number on the new user page
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
  Then I enter my email again on the new user page
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

@restrictedSignInFormRequired
@javascript
Scenario: The new user page redirects to the form unavailable page if the form is outside of its time restriction
  When I go to the new user page with a restricted form ID
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter my email again on the new user page
  Then I can click the form submit button on the new user page
  Then I click on the form submit button on the new user page
  Then I am redirected to an unavailable page from the new user page