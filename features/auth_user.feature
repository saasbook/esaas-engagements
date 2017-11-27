@wip
Feature: only authorized users can create, edit, and destroy users, orgs, apps, engagements, and iterations
  As a staff of the course
  So that nothing in the database is modified by unauthorised users
  I want to add user authentication check before any modification to the database

Background: Logged in, users, apps, orgs, engagements and iterations exist 
  Given the following apps exist:
    | id | name  | description | org_id | status  |
    | 1  | app1  | test        | 1      | pending |
    | 2  | app2  | test        | 1      | pending |
  And the following orgs exist:
    | id | name | contact_id |
    | 1  | org1 | 1          |
    | 2  | org2 | 1          |
  And the following users exist:
    | id | name  | github_uid      | email          | type_user     |
    | 1  | user1 | esaas_developer | test@user.com  | staff         |
    | 2  | user2 |                 | test1@user.com | student       |
    | 3  | user3 |                 | test2@user.com | coach         |
  And the following engagements exist:
    | id | app_id | coaching_org_id | coach_id | contact_id | team_number | start_date | student_names |
    | 1  | 1      | 1               | 1        | 2          | 1           | 2017-03-25 | s1, s2, s3    |
    | 2  | 1      | 1               | 1        | 2          | 2           | 2017-08-25 | s4, s5, s6    |
  And the following iterations exist:
    | id | engagement_id | end_date   |
    | 1  | 1             | 2017-04-14 |
    | 2  | 1             | 2017-04-28 |
  
Scenario: Happy Path - Can create new app, edit and destroy existing app if I am staff
  #Story ID: 153042639
  Given I am logged in as "user1"
  And I follow "Apps"
  And I press "New App"
  Then I should see "New App"
  And I press "Back"
  And I press "Edit" for "app1"
  Then I should see "Editing App"
  And I press "Back"
  And I press "Destroy" for "app1"
  Then I should see "App was successfully destroyed."
  
Scenario: Sad Path - Cannot create new app, edit and destroy existing app if I am not staff
  #Story ID: 153042639
  Given I am logged in as "user2"
  And I follow "Apps"
  And I press "New App"
  Then I should see "error"
  And I press "Back"
  And I press "Edit" for "app1"
  Then I should see "error"
  And I press "Back"
  And I press "Destroy" for "app1"
  Then I should see "error"
  
Scenario: Happy Path - Can create new org, edit and destroy existing org if I am staff
  #Story ID: 153042639
  Given I am logged in as "user1"
  And I follow "Orgs"
  And I press "New Org"
  Then I should see "New Organization"
  And I press "Back"
  And I press "Edit" for "org1"
  Then I should see "Editing"
  And I press "Back"
  And I press "Destroy" for "org1"
  Then I should see "Org was successfully destroyed."
  
Scenario: Sad Path - Cannot create new org, edit and destroy existing org if I am not staff
  #Story ID: 153042639
  Given I am logged in as "user2"
  And I follow "Orgs"
  And I press "New Org"
  Then I should see "error"
  And I press "Back"
  And I press "Edit" for "org1"
  Then I should see "error"
  And I press "Back"
  And I press "Destroy" for "org1"
  Then I should see "error"

Scenario: Happy Path - Can create new user, edit and destroy existing user if I am staff
  Given I am logged in as "user1"
  And I follow "Users"
  And I press "New User"
  Then I should see "New User"
  And I press "Back"
  And I press "Edit" for "user3"
  Then I should see "Editing"
  And I press "Back"
  And I press "Destroy" for "user3"
  Then I should see "User was successfully destroyed."
  
Scenario: Sad Path - Cannot create new user, edit and destroy existing user if I am not staff
  #Story ID: 153042639
  Given I am logged in as "user2"
  And I follow "Users"
  And I press "New User"
  Then I should see "error"
  And I press "Back"
  And I press "Edit" for "user3"
  Then I should see "error"
  And I press "Back"
  And I press "Destroy" for "user3"
  Then I should see "error"

Scenario: Happy Path - Can use the Create page and submit the form if I am staff
  #Story ID: 153042639
  Given I am logged in as "user1"
  And I follow "Create"
  Then I should see "Create New User, Org, and App"
  
Scenario: Sad Path - Cannot use the Create page and submit the form if I am not staff
  #Story ID: 153042639
  Given I am logged in as "user2"
  And I follow "Create"
  Then I should see "error"
 
Scenario: Happy Path - Can create new engagement, edit and destroy existing engagement if I am staff
  #Story ID: 153042639
  Given I am logged in as "user1"
  And I follow "Apps"
  Given I follow "app1"
  And I press "New Engagement"
  Then I should see "New Engagement For"
  And I press "Back"
  And I press "Edit" for "2017-03-25"
  Then I should see "Editing Engagement for"
  And I press "Back"
  And I press "Destroy" for "2017-03-25"
  Then I should see "Engagement was successfully destroyed"
  
Scenario: Sad Path - Cannot create new engagement, edit and destroy existing engagement if I am not staff
  #Story ID: 153042639
  Given I am logged in as "user2"
  And I follow "Apps"
  Given I follow "app1"
  And I press "New Engagement"
  Then I should see "error"
  And I press "Back"
  And I press "Edit" for "2017-03-25"
  Then I should see "error"
  And I press "Back"
  And I press "Destroy" for "2017-03-25"
  Then I should see "error"

Scenario: Happy Path - Can create new iteration, edit and destroy existing iterations if I am staff
  #Story ID: 153042639
  Given I am logged in as "user1"
  And I follow "Apps"
  And I follow "app1"
  And I follow "2017-03-25"
  And I press "Add Iteration"
  Then I should see "New Iteration for Engagement from"
  And I press "Back"
  And I press "Edit" for "2017-04-14"
  Then I should see "Edit Customer Feedback"
  And I press "Back"
  And I press "Destroy" for "2017-04-14"
  Then I should see "Iteration was successfully destroyed"
  
Scenario: Sad Path - Cannot create new iteration, edit and destroy existing iterations if I am not staff
  #Story ID: 153042639
  Given I am logged in as "user2"
  And I follow "Apps"
  And I follow "app1"
  And I follow "2017-03-25"
  And I press "Add Iteration"
  Then I should see "error"
  And I press "Back"
  And I press "Edit" for "2017-04-14"
  Then I should see "error"
  And I press "Back"
  And I press "Destroy" for "2017-04-14"
  Then I should see "error"
  