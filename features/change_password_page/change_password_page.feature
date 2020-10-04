Feature: Change Password Page
  As an admin
  I want to be able to change my password
  So that I can regain security if my password is compromised

@javascript
@authRequired
Scenario: Change Password button redirects to change password page
  When I go to the homepage
  Then I log in
  Then I click the change password button
  Then I am redirected to the change password page

@javascript
@authRequired
Scenario: Change Password button is unclickable without both fields being equal
  When I go to the homepage
  Then I log in
  Then I click the change password button
  Then I am redirected to the change password page
  Then The change password button is unclickable
  Then I fill in the change password fields
  Then I can click the change password button
