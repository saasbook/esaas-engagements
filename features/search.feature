Feature: searching to quickly find apps, orgs, users
	As a logged in user
	So that I can quickly find what I'm looking for
	I should be able to search the app for exactly what I'm looking for

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

    And I'm logged in on the orgs page

Scenario: search for an app
	Given I search for "app1"
	Then I should see "Apps"
	And I should see "Orgs"
	And I should see "Users"
	And I should see "app1"
	And I should not see "app2"
	And I should not see "app3"