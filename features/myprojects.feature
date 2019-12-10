 Feature: after a user logs in with their github id they have access to my projects tab
   As a logged in user on any page of ESaaS Engagements with a Taskbar
   I should see a tab labeled “My Projects”
   So that I can manage my projects

   Background: seed data and log in
     Given the following apps exist:
       | id  | name  | description | org_id | status  | pivotal_tracker_url | repository_url | deployment_url  | features |
       | 101 | app1  | test1       | 1      | pending | p1.com              | repo-url1.com  | deploy-url1.com | f1       |
       | 102 | app2  | test2       | 1      | pending | p2.com              | repo-url2.com  | deploy-url2.com | f2       |
       | 103 | app3  | test3       | 1      | pending | p3.com              | repo-url3.com  | deploy-url3.com | f3       |
       | 104 | app4  | test4       | 4      | pending | p3.com              | repo-url3.com  | deploy-url3.com | f3       |

     And the following orgs exist:
       | id | name | contact_id |
       | 1  | org1 | 1          |
       | 2  | org2 | 1          |
       | 3  | org3 | 1          |
       | 4  | org4 | 2          |

     And the following users exist:
       | id | name  | github_uid      | email          | user_type     |
       | 1  | user1 | esaas_developer | test@user.com  | client        |
       | 2  | user2 |                 | test1@user.com | student       |
       | 3  | user3 |                 | test2@user.com | client        |
       | 4  | user4 |                 | test4@user.com | client        |

 # ---------------------------- Menu bar ----------------------------------------
 # Story ID: 169387986
 Scenario: A user that is not logged in cannot see 'My Projects' tab
   Given I am not logged in
   Then I should not see "My Projects"

 # Story ID: 169387986
 Scenario: A user that is logged in can see 'My Projects' tab
   Given I am logged in
   Then I should see "My Projects"

 # ------------------------- My Projects Index ----------------------------------
 # Story ID: 169387986
 Scenario: A logged in user can see list of their projects in 'My Projects' tab
   Given I am logged in
   When I follow "My Projects"
   Then I should see the following apps in "apps_table" in the given order:
     | name  | description | org_id    | status  |
     | app1  | test1       | org1      | pending |
     | app2  | test2       | org1      | pending |
     | app3  | test3       | org1      | pending |
   And I should not see "app4"

 # -------------------- Projects Information Page -----------------------------
 Scenario: A logged in user can view the Projects Information Page through the 'My Projects' index
   Given I am logged in
   When I follow "My Projects"
   When I follow "app1"
   Then I should see "app1"
   Then I should see "Status: pending"
   Then I should see "test1"
   Then I should see "f1"
   Then I should see "p1.com"
   Then I should see "repo-url1.com"
   Then I should see "deploy-url1.com"

 Scenario: A logged in user can see buttons on the Projects Information Page through the 'My Projects' index
   Given I am logged in
   When I follow "My Projects"
   When I follow "app1"
   Then I should see "app1"
   Then I should see "Back"
   Then I should see "Request Change"

 Scenario: A logged in user can see buttons on the Projects Information Page through the 'My Projects' index
   Given I am logged in
   When I follow "My Projects"
   When I follow "app1"
   When I follow "Back"
   Then I should be on the my projects page

 # -------------------- My Project Request Change -----------------------------
 Scenario: A logged in user can Request a change to their project through the Project Information Page
   Given I am logged in
   When I follow "My Projects"
   When I follow "app1"
   When I follow "Request Change"
   Then I should see /Request Changes for "app1"/
   # Then I should see "Send Request" TODO: Not passing

 Scenario: A logged in user will see the "Request Change" button change to "Update Request" when a Change Request is submitted
   Given I am logged in
   When I follow "My Projects"
   Then I should not see "Update Request"
   And I follow "app1"
   And I follow "Request Change"
   And I fill in "description" with "123abc"
   And I fill in "features" with "123abc"
   And I press "Send Request"
   Then I should see "Update Request"
   When I follow "My Projects"
   Then I should see "Update Request"

 Scenario: A logged in user can view the Projects Information Page through the 'My Projects' index
   Given I am logged in
   When I follow "My Projects"
   When I follow "app1"
   Then I should see "app1"
   Then I should see "Status: pending"
   Then I should see "test1"
   Then I should see "f1"
   Then I should see "p1.com"
   Then I should see "repo-url1.com"
   Then I should see "deploy-url1.com"
   When I follow "Request Change"
   Then I should see "app1"
   Then I should see "test1"
   Then I should see "f1"
   Then I should see "p1.com"
   Then I should see "repo-url1.com"
   Then I should see "deploy-url1.com"
   And I fill in "description" with "123abc"
   And I fill in "features" with "123abcd"
   And I press "Send Request"
   When I follow "Update Request"
   Then I should see "app1"
   Then I should see "123abc"
   Then I should see "123abcd"
   Then I should see "p1.com"
   Then I should see "p1.com"
   Then I should see "repo-url1.com"
   Then I should see "deploy-url1.com"

   Scenario: A logged-in client can delete a Change Request on the Update/Edit Request Page
   Given I am logged in
   When I follow "My Projects"
   And I follow "app1"
   And I follow "Request Change"
   And I fill in "description" with "123abc"
   And I fill in "features" with "123abc"
   And I press "Send Request"
   Then I should see "Update Request"
   When I follow "Update Request"
   And I press "Delete Request"
   Then I should see "Successfully deleted edit request for: app1"
