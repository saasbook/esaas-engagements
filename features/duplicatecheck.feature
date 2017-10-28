Feature: Duplicate users/orgs checking
	As a developer
	So that there is no duplicate uers/orgs
	I want the app to check duplicate users/org
  
Background: User is trying to sign up
    Given the following orgs exist:
        | name | contact_id |
        | org1 | 1          |
        | org2 | 2          |
        | org3 | 3          |

    And the following users exist:
        | name  | github_uid      | email          |
        | user1 | esaas_developer | user1@user.com |
        | user2 |                 | user2@user.com |
        | user3 |                 | user3@user.com |

Scenario: user fills in information in new user page
	Given I try to sign up as a user with email "user1@user.com"
	When I press "Save"
	Then I should see "User already exists"
	And I should not see "User successfully created."
	
Scenario: user fills in information in new org page
	Given I try to sign up as an org with org name "org1"
	When I press "Save"
	Then I should see "Org already exists"
	And I should not see "Org was successfully created."