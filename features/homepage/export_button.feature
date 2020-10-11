Feature: Export Button
  As an admin
  I want a "Export Data" button on the main page
  So I can export user data when I need to share it

@javascript
@authRequired
Scenario: clicking the export button downloads a csv file containing user data
When I go to the homepage
Then I log in
Then I see the export button
