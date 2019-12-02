Feature: staff should be able to approve or comment on requested feature changes or additions made by a user
  As a logged in Coach user on ESaaS Engagements
  I should see a tab labeled “App Edit Requests”
  So that I can approve of or give feedback on requested feature changes or new features on existing apps made by users

  Background: seed data and log in
    Given the following apps exist:
      | id  | name  | description | org_id | status      | pivotal_tracker_url | repository_url | deployment_url  | features |
      | 101 | app1  | test1       | 1      | pending     | p1.com              | repo-url1.com  | deploy-url1.com | f1       |
      | 102 | app2  | test2       | 1      | pending     | p2.com              | repo-url2.com  | deploy-url2.com | f2       |
      | 103 | app3  | test3       | 1      | development | p3.com              | repo-url3.com  | deploy-url3.com | f3       |
      | 104 | app4  | test4       | 4      | pending     | p3.com              | repo-url3.com  | deploy-url3.com | f3       |

    And the following orgs exist:
      | id | name | contact_id |
      | 1  | org1 | 2          |
      | 2  | org2 | 2          |
      | 3  | org3 | 1          |
      | 4  | org4 | 2          |

    And the following App Edit Requests exist:
      | id | description  | features    | feedback | status      | approval_time | app_id | requester_id    | approver_id | created_at                 | updated_at |
      | 1  | app1         | test1       |          | submitted   |               | 101    | 2               |             | 2019-11-20 7:44:50 -0800   |            |
      | 2  | app2         | test2       |          | submitted   |               | 102    | 2               |             | 2019-11-20 08:05:50 -0800  |            |

    And the following users exist:
      | id | name  | github_uid      | email          | user_type     |
      | 1  | user1 | esaas_developer | test@user.com  | coach         |
      | 2  | user2 | mock_user1      | test1@user.com | client        |
      | 3  | user3 |                 | test2@user.com | student       |
      | 4  | user4 |                 | test4@user.com | client        |

# ---------------------------- Menu bar ----------------------------------------
Scenario: A user that is not logged in cannot see 'App Edit Requests' tab
Given I am not logged in
Then I should not see "App Edit Requests"

Scenario: A logged in user that is not a Coach cannot see 'App Edit Requests' tab
#  Given I am logged in
#  Then I should not see "App Edit Requests"

Scenario: A logged in user that is a Coach can see the 'App Edit Requests' tab
Given I am logged in
Then I should see "App Edit Requests"

# ------ Previously: App Edit Requests Index -- Currently: MyApprovalRequests Index -------

Scenario: A logged in coach user can see list of App Edit Requests in 'App Edit Requests' tab
  Given I am logged in
  When I follow "App Edit Requests"
  Then I should see "app1" before "app2"
  And I should not see "app4"
  And I should not see "app3"

# -------------------- App Edit Request Show Page -----------------------------
Scenario: A logged in coach user can view an App Edit (Feature Change) Request through the 'App Edit Requests' index
  Given I am logged in
  When I follow "App Edit Requests"
  When I follow the App Edit Request with id 102
  Then I should see /Edit request for "app2"/
