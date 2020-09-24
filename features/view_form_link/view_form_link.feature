Feature: View form link
As an admin,
I want to see the sign-in form link next to the event details
so I can copy the link whenever I need it.

@formRequired
@javascript
Scenario: Form link is visible on the home page when the form and event exist in the system
  When I go to the homepage to view the form link
  Then I see the form id on the homepage
  Then the form id links to the form page
  Then I click the link
  Then I go to the form page from the home page
