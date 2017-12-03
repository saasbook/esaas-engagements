Feature: The iterations' 'Edit' page should have a 'Back' button
  As a user of the app
  So that I can navigate around the app's pages
  I want to click on "Back" on the edit Iterations to go back to the Iteration page

Background: Logged in, users, apps, orgs, engagements and iterations exist
  Given the following apps exist:
    | id | name  | description | org_id | status  |
    | 1  | app1  | test        | 1      | pending |
    | 2  | app2  | test        | 1      | pending |
    | 3  | app3  | test        | 1      | pending |
  And the following orgs exist:
    | id | name | contact_id |
    | 1  | org1 | 1          |
    | 2  | org2 | 1          |
    | 3  | org3 | 1          |
  And the following users exist:
    | id | name  | github_uid      | email          |
    | 1  | user1 | esaas_developer | test@user.com  |
    | 2  | user2 |                 | test1@user.com |
    | 3  | user3 |                 | test2@user.com |

  And the following engagements exist:
    | id | app_id | coach_id | team_number | start_date | student_names |
    | 1  | 1      | 1        | 1           | 2017-03-25 | s1, s2, s3    |
    | 2  | 1      | 1        | 2           | 2017-08-25 | s4, s5, s6    |
  And the following iterations exist:
    | id | engagement_id | end_date   |
    | 1  | 1             | 2017-04-14 |
    | 2  | 1             | 2017-04-28 |
  And I'm logged in on the orgs page
  And I follow "Apps"
  And I follow "app1"
  And I follow "2017-03-25"
  And I press "Edit" for "2017-04-14"
  And I should see "Edit Customer Feedback"

Scenario: There is a "Back to App" button in the Edit Iteration page and it works
  #Story ID: 153043640
  Then I should see "Back to App"
  And I follow "Back to App"
  Then I should see "app1"
  And I should see "Engagements"

Scenario: There is a "Back to Iteration" button in the Edit Iteration page and it works
  #Story ID: 153043640
  Then I should see "Back to Iteration"
  And I follow "Back to Iteration"
  Then I should see "Iterations for app1"
  And I should see "2017-04-14"
