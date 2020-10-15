Feature: View form user count
As an admin,
I want to see the user count next to form link in events details
so I know how many people have filled out the form.

@formRequired
@javascript
@authRequired
Scenario: Form link is visible on the home page when the form and event exist in the system
  When I go to the homepage to view the form user count
  Then I log in
  Then I go to the event list
  Then I click the all events filter
  Then I see the form user count on the homepage
