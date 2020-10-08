Feature: Form process integration
As a member,
I want to fill out a sign-in form
so my attendance is recorded.

@formRequired
@javascript
Scenario: Filling out a form as a first time user
  When I go to the form page
  Then I enter my UIN on the form page
  Then I click the form submit button on the form page
  Then I navigate to the new user page
  Then I enter my first name on the new user page
  Then I enter my last name on the new user page
  Then I enter my major on the new user page
  Then I select my graduation year on the new user page
  Then I enter my email on the new user page
  Then I enter my phone number on the new user page
  Then I click the form submit button on the new user page
  Then I navigate to the confirm submission page

@formRequired
@userRequired
@javascript
Scenario: Filling out a form as a returning user
  When I go to the form page
  Then I enter my UIN on the form page
  Then I click the form submit button on the form page
  Then I navigate to the confirm submission page
