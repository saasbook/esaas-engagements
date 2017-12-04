Feature: Different users can comment on an App

	As a user who uses ESaaS Engagements Tracker
	So that I could comment on an App with other users
	I want to add a comment section for each App

Background: a user is logged into the app
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
        | name  | github_uid      | email          |
        | user1 | esaas_developer | test1@user.com |
        | user2 |                 | test2@user.com |
        | user3 |                 | test3@user.com |

    And I am logged in
    And I follow "app1"

Scenario: user does not fill in the comment form (sad path)
	Given I fill in "Write a comment..." with ""
	And the time is "1997-07-16T19:20"
	When I press "Post"
	Then I should not see "user1"

Scenario: user fills in some comment in the form (happy path)
	Given I fill in "Write a comment..." with "This App is AWESOME!"
	And the time is "1997-07-16T19:20"
	When I press "Post"
	Then I should see "This App is AWESOME!"
	And I should see "user1"
	And I should see "Jul 16, 1997 at 7:20:00 PM"

Scenario: user can edit a comment
    Given I fill in "Write a comment..." with "This App is AWESOME!"
    And I press "Post"
    And I follow "Edit"
    And I fill in "comment_content" with "different comment"
    And I press "Post"
    Then I should see "different comment"

Scenario: user can delete a comment
    Given I fill in "Write a comment..." with "This App is AWESOME!"
    And I press "Post"
    And I follow "Delete"
    Then I should not see "This App is AWESOME!"

Scenario: user cannot edit a comment of other users
    Given the following comments exist for "app1":
        | user_id   | content            |
        | 2         | add search feature |
    And I go to the app details page for "app1"
    When I follow "Edit"
    Then I should see "You don't have authorization to user2's comment!"
    And I should see "add search feature"

Scenario: user cannot edit/delete a comment of other users
    Given the following comments exist for "app1":
        | user_id   | content            |
        | 2         | add search feature |
    And I go to the app details page for "app1"
    When I follow "Delete"
    Then I should see "You don't have authorization to user2's comment!"
    And I should see "add search feature"

Scenario: new comment cannot be blank
    When I fill in "Write a comment..." with ""
    And I press "Post"
    Then I should not see any comments

Scenario: edit comment cannot be blank
    Given the following comments exist for "app1":
        | user_id   | content            |
        | 1         | add search feature |
    And I go to the app details page for "app1"
    And I follow "Edit"
    When I fill in "comment_content" with ""
    And I press "Post"
    And I go to the app details page for "app1"
    Then I should see "add search feature"