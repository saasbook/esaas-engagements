Feature: engagements and iterations have edit and destroy buttons
  As a staff of the course
  So that I can manage the engagements and iterations
  I want to add edit and destroy buttons to engagement page and iteration page

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
    | 4  | user4 |                 | test3@user.com |
    | 5  | user5 |                 | test@user.com |
    | 6  | user6 |                 | test@user.com |
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

Scenario: Can edit and destroy all existing engagements
  #Story ID: #152689950
  Then I should see "2017-03-25" has button "Edit"
  And I should see "2017-08-25" has button "Edit"
  And I should see "2017-03-25" has button "Destroy"
  And I should see "2017-08-25" has button "Destroy"

Scenario: Editing existing engagements is successful
  #Story ID: #152689950
  And I press "Edit" for "2017-03-25"
  Then I should see "Editing Engagement for"
  And I press "Save"
  Then I should see "Engagement was successfully updated."

Scenario: Destroying existing engagements is successful
  #Story ID: #152689950
  And I press "Destroy" for "2017-03-25"
  Then I should see "Engagement was successfully destroyed"

Scenario: Newly Added Engagement also has buttons
  #Story ID: #152689950
   Given I create a new engagement for "app1"
   When I fill in the engagement fields as follows:
       | field                  | value      |
       | Team number            | Team3          |
       | Student names          | Student1   |
  And I press "Save"
  Then I should see "Engagement was successfully created"
  Then I should see "Team3" has button "Edit"
  And I should see "Team3" has button "Destroy"

Scenario: Can edit and destroy all existing iterations
  #Story ID: #152689950
  Given I follow "2017-03-25"
  Then I should see "Iterations for app1"
  And I should see "2017-04-14" has button "Edit"
  And I should see "2017-04-28" has button "Edit"
  And I should see "2017-04-14" has button "Destroy"
  And I should see "2017-04-28" has button "Destroy"

Scenario: Editing existing iterations is successful
  #Story ID: #152689950
  Given I follow "2017-03-25"
  And I press "Edit" for "2017-04-14"
  And I should see "Edit Customer Feedback"
  And I press "Save Changes"
  And I should see "Iteration was successfully updated."

Scenario: Destroying existing iterations is successful
  #Story ID: #152689950
  Given I follow "2017-03-25"
  And I press "Destroy" for "2017-04-14"
  Then I should see "Iteration was successfully destroyed"

Scenario: Newly Added Iteration also has buttons
  #Story ID: #152689950
  Given I follow "2017-03-25"
  And the time is "2017-11-14T19:20"
  And I follow "Add Iteration..."
  And I select "2017 November 14" for the enddate
  And I press "Save"
  Then I should see "Iteration was successfully created"
  And I should see "2017-11-14" has button "Edit"
  And I should see "2017-11-14" has button "Destroy"