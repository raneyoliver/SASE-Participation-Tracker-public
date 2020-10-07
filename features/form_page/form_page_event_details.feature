Feature: Form page
As a user,
I want to see the description for an event when filling out a form
so that I know more about the event.

@formRequired
@javascript
Scenario: Event type is displayed on the form page
  When I go to the form page to see event details
  Then I see the event type related to the form

@formRequired
@javascript
Scenario: Event description is displayed on the form page
  When I go to the form page to see event details
  Then I see the event description related to the form
