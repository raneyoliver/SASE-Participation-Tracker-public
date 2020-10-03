Feature: Dynamic form type on form page
As a user,
I want to fill out an RSVP form
so my RSVP is recorded.

@formRequired
@javascript
Scenario: Form page calls a sign-in form a sign-in form
  When I go to the form page to see form types
  Then I see that the form is a sign-in form

@RSVPFormRequired
@javascript
Scenario: Form page calls an RSVP form an RSVP form
  When I go to the form page to see form types
  Then I see that the form is an RSVP form
