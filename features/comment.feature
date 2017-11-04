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
        | name  | github_uid      | email         |
        | user1 | esaas_developer | test@user.com |
        | user2 |                 | test@user.com |
        | user3 |                 | test@user.com |

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
