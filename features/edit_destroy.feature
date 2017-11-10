Feature: engagements and iterations have edit and destroy buttons
  As a staff of the course
  So that I can manage the engagements and iterations
  I want to add edit and destroy buttons to engagement page and iteration page

Background: Logged in
  
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

  And I'm logged in on the orgs page
  And I am logged in as a "staff"
  And I follow "Apps"
  And I follow "app1"
  
Scenario: Can create and edit multiple engagements
  #Story ID: #152689950
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
  
  Then I should see "Team1" has button "Edit"
  And I should see "Team2" has button "Edit"

Scenario: Can create and destroy multiple engagements
  #Story ID: #152689950
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
  Then I should see "Team1" has button "Destroy"
  And I should see "Team2" has button "Destroy"

Scenario: Can destroy existing engagements
  #Story ID: #152689950
  Given I follow "app1"
  And the following engagements exist:
    | id | app_id | coaching_org_id | coach_id | contact_id | team_number | start_date | student_names |
    | 1  | 1      | 1               | 1        | 2          | 1           | 2017-03-25 | s1, s2, s3    |
    | 2  | 1      | 1               | 1        | 2          | 2           | 2017-08-25 | s4, s5, s6    |

  And the following iterations exist:
    | id | engagement_id | end_date   |
    | 1  | 1             | 2017-04-14 |
    | 2  | 1             | 2017-04-28 |

  And I press "Destroy" for the engagement for team number "2"
  Then I should see "Engagement was successfully destroyed"

Scenario: Each iteration has edit and destroy button
  #Story ID: #152689950
  Given I follow "app1"
  And the following engagements exist:
    | id | app_id | coaching_org_id | coach_id | contact_id | team_number | start_date | student_names |
    | 1  | 1      | 1               | 1        | 2          | 1           | 2017-03-25 | s1, s2, s3    |
    | 2  | 1      | 1               | 1        | 2          | 2           | 2017-08-25 | s4, s5, s6    |
  And the following iterations exist:
    | id | engagement_id | end_date   |
    | 1  | 1             | 2017-04-14 |
    | 2  | 1             | 2017-04-28 |
  Given I am at the engagment iterations page for engagement id "1"
  Then I should see "Iterations for app1"
  And I should see "Edit" for each iteration
  And I should see "Destroy" for each iteration
  And I press "Destroy" for Iteration with id "2"
  Then I should see "Iteration was successfully destroyed"