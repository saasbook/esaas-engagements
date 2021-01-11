Feature: staff should be able to approve or comment on requested feature changes or additions made by a user
  As a logged in Coach user on ESaaS Engagements
  I should see a tab labeled "App Edit Requests"
  So that I can approve of or give feedback on requested feature changes or new features on existing apps made by users
  Background: seed data and log in
    Given the following apps exist:
      | id  | name  | description | org_id | status      | pivotal_tracker_url | repository_url | deployment_url  | features |
      | 101 | app1  | test1       | 1      | pending     | p1.com              | repo-url1.com  | deploy-url1.com | f1       |
      | 102 | app2  | test2       | 1      | pending     | p2.com              | repo-url2.com  | deploy-url2.com | f2       |
      | 103 | app3  | test3       | 1      | development | p3.com              | repo-url3.com  | deploy-url3.com | f3       |
      | 104 | app4  | test4       | 4      | pending     | p3.com              | repo-url3.com  | deploy-url3.com | f3       |
      | 105 | app5  | test5       | 3      | development | p4.com              | repo-url4.com  | deploy-url3.com | f5       |
      | 106 | app6  | test6       | 3      | pending     | p6.com              | repo-url6.com  | deploy-url6.com | f6       |
    And the following orgs exist:
      | id | name | contact_id |
      | 1  | org1 | 2          |
      | 2  | org2 | 2          |
      | 3  | org3 | 1          |
      | 4  | org4 | 2          |
    And the following App Edit Requests exist:
      | description  | features    | feedback | status      | approval_time | app_id | requester_id    | approver_id | created_at                 | updated_at |
      | app1         | test1       |          | submitted   |               | 101    | 2               |             | 2019-11-20 7:44:50 -0800   |            |
      | app2         | test2       |          | submitted   |               | 102    | 2               |             | 2019-11-20 08:05:50 -0800  |            |
      | app6         | test3       |          | reviewed    |               | 106    | 2               |             | 2019-11-20 08:05:50 -0800  |            |
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
  When I follow "App Edit Requests 2"
  Then I should see "app1" before "app2"
  And I should not see "app4"
  And I should not see "app3"
# -------------------- App Edit Request Show Page -----------------------------
Scenario: A logged in coach user can view an App Edit (Feature Change) Request through the 'App Edit Requests' index
  Given I am logged in
  When I follow "App Edit Requests"
  When I follow the App Edit Request with id 102
  Then I should see /Edit request for "app2"/

Scenario: A coach user requests an edit on his/her project and verifies that
          approving the request via the App Edit Requests page correctly
          updates the approval status of the request in the  project information page
  Given I am logged in
  Then I should see "App Edit Requests 2"
  When I follow "My Projects"
  Then I should be on the my projects page
  When I follow "app5"
  Then I should not see "Your app edit request has been submitted to staff for review and approval. Staff has not yet reviewed/approved this request."
  When I follow "Back"
  And I follow Request Change with id 105
  Then I should see "There are currently no edit requests for your app. You can request new edits for you app here."
  When I fill in "description" with "This is app5"
  And I fill in "features" with "login, logout"
  Then I press "Send Request"
  Then I should see "Your app edit request has been submitted to staff for review and approval. Staff has not yet reviewed/approved this request."

  Then I should see "App Edit Requests 3"
  When I follow "App Edit Requests"
  Then I should see "app1"
  Then I should see "app2"
  Then I should see "app5"

  And I follow the App Edit Request with id 105
  Then I should see "This is app5"
  And I should see "login, logout"
  When I fill in "feedback" with "I can only do login"
  And I press "Post Feedback"
  Then I should see "App Edit Requests 2"
  And I follow the App Edit Request with id 105
  Then I should see "reviewed"

  When I follow "My Projects"
  Then I should be on the my projects page
  When I follow "app5"
  Then I should see "Staff has reviewed and left feedback on your edit request. Kindly review staff feedback and update the request."
  And I should see "I can only do login"

  Given I follow "Update Edits"
  When I press "Update Request"
  Then I should see "There were no updates to edits made."

  Given I fill in "features" with "login"
  And I press "Update Request"
  Then I should see "Successfully updated edit request."
  And I should see "You resubmitted an edit request after staff left feedback but staff has not yet reviewed your updates."
  Then I should see "App Edit Requests 3"

  When I follow "App Edit Requests"
  Then I should see "app1"
  Then I should see "app5"
  And I uncheck "resubmitted"
  And I press "Filter Requests"
  Then I should not see "app5"
  And I check "resubmitted"

  And I uncheck "submitted"
  Then I press "Filter Requests"
  Then I should not see "app1"

  And I follow the App Edit Request with id 105
  And I press "Post Feedback and Approve"
  Then I should see /You have successfully approved edits for "app5"./
  Then I should see "App Edit Requests 2"
  And I press "Filter Requests"
  Then I should not see "app5"

Scenario: Client can view and link to reviewed requests through icon dropdown menu
  Given I am logged in
  When I follow "My Projects"
  Then I should see "Your request has been reviewed!"
  When I click on the "requests" icon
  Then I should see "View Feedback for app6"
  And I should not see "View Feedback for app1"
  When I follow "View Feedback for app6"
  Then I should see "Edit Request for app6"
  Then I should see "test6"
  Then I should see "f6"
