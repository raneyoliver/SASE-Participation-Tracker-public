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
  Then The change password tooltip is displayed
  Then I fill in the change password fields
  Then I can click the change password button
  Then The change password tooltip is not displayed

@javascript
@authRequired
Scenario: After changing the password, the new password is saved
  When I go to the homepage
  Then I log in
  Then I click the change password button
  Then I am redirected to the change password page
  Then I fill in the change password fields
  Then I click the change password button
  Then I get redirected to the homepage
  Then I click the logout button
  Then I enter the old credentials
  Then I am unable to log in

@javascript
@authRequired
Scenario: After changing the password, the old password no longer works
  When I go to the homepage
  Then I log in
  Then I click the change password button
  Then I am redirected to the change password page
  Then I fill in the change password fields
  Then I click the change password button
  Then I get redirected to the homepage
  Then I click the logout button
  Then I log in with the new credentials
  Then I get redirected to the homepage

Scenario: I cannot access the change password page without being logged in
  When I go to the change password page directly
  Then I get redirected to the log in page
