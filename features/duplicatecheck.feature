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
        | name  | github_uid      | email          | user_type     |
        | user1 | esaas_developer | user1@user.com | coach         |
        | user2 |                 | user2@user.com | student       |
        | user3 |                 | user3@user.com | client        |

    And I'm logged in on the orgs page

Scenario: user fills in information in new user page
    Given I am on the Users page
    When I follow "New User"
    And I fill in "User Name" with "randomuser"
    And I fill in "Email" with "user1@user.com"
    And I press "Create User"
    Then I should see "User E-mail address has already been taken"
    And I should not see "User successfully created."

Scenario: user fills in information in new user page
    Given I am on the Users page
    When I follow "New User"
    And I fill in "User Name" with "new_user"
    And I fill in "Email" with "new_user@user.com"
    And I press "Create User"
    Then I should see "User successfully created."
    And I should not see "User E-mail address has already been taken"

Scenario: user fills in information in new org page
    Given I am on the Orgs page
    When I follow "New Org"
    And I fill in "Organization Name" with "org1"
    And I press "Create Org"
    Then I should see "Org Name has already been taken"
    And I should not see "Org was successfully created."

Scenario: user fills in information in new org page
    Given I am on the Orgs page
    When I follow "New Org"
    And I fill in "Organization Name" with "new_org"
    And I press "Create Org"
    Then I should see "Org was successfully created."
    Then I should not see "Org Name has already been taken"
