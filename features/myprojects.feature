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
  Then I should see the following apps in "apps_table" in the given order: # TODO: implement step definition
    | name  | description | org_id    | status  |
    | app1  | test1       | org1      | pending |
    | app2  | test2       | org1      | pending |
    | app3  | test3       | org1      | pending |
  And I should see the following apps in "apps_table":
    | name  | description | org_id    | status  |
    | app4  | test4       | org2      | pending |

# -------------------- Projects Information Page -----------------------------
Scenario: A logged in user can view the Projects Information Page through the 'My Projects' index
  Given I am logged in
  When I follow "My Projects"
  When I follow "app1"
  Then I should see "app1"
  Then I should see "Status: pending"
  Then I should see "test1" #TODO: description use div later
  Then I should see "f1" #TODO: FEATURES use div later
  Then I should see "p1.com" #TODO: Pivotal tracker url use div later
  Then I should see "repo-url1.com" #TODO: Repo URL use div later
  Then I should see "deploy-url1.com" #TODO: Deployment URL use div later

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
  Then I should see be on the myprojects page



# TODO: test pagination and order by status once client sends list of status order
