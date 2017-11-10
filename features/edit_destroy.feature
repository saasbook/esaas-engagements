Feature: a user can be created
  As a staff of the course
  So that I can manage the engagements and iterations
  I wnat to add edit and destroy buttons to engagement page and iteration page

Background: Logged in
  Given the following apps exist:
    | name  | description | org_id | status  |
    | app1  | test        | 1      | pending |
    | app2  | test        | 1      | pending |
    | app3  | test        | 1      | pending |
  And the following orgs exist:
    | name | contact_id |
    | org1 | 1          |
    | org2 | 1          |
    | org3 | 1          |

  And the following users exist:
    | name  | github_uid      | email         |
    | user1 | esaas_developer | test@user.com |
    | user2 |                 | test@user.com |
    | user3 |                 | test@user.com |
    | user4 |                 | test@user.com |
    | user5 |                 | test@user.com |
    | user6 |                 | test@user.com |

  And I'm logged in on the orgs page
  And I am logged in as a "staff"
  And I follow "Apps"
  And I follow "app1"
  And I create a new engagement for "app1"
  And I fill in the engagement fields as follows:
       | field                  | value      |
       | Team number            | Team1      |
       | Student names          | Student1   | 
  And I select "user1 user2 user3" as Team members
  And I press "Save"
  And I create a new engagement for "app1"
  And I fill in the engagement fields as follows:
       | field                  | value      |
       | Team number            | Team2      |
       | Student names          | Student2   |
  And I select "user4 user5 user6" as Team members
  And I press "Save"
  
Scenario: Can edit all engagements
  #Story ID: #152689950
  Then I should see "Team1" has button "Edit"
  And I should see "Team2" has button "Edit"

Scenario: Can destroy all engagements
  #Story ID: #152689950
  Then I should see "Team1" has button "Destroy"
  And I should see "Team2" has button "Destroy"
