Feature: URL can be optional when status is vetting

    As an admin user
    So that I can create vetting app when I don't have URL
    I want to create an app without filling URL

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

    And the following apps exist:
        | name         | description  | org_id | status          | id |
        | AFX Dance    | Awesome!     | 3      | vetting_pending | 1  |

    And I'm logged in on the orgs page

Scenario: I cannot update to a non-vetting app without URL
    Given I am on the edit app page for app id: "1"
    When I fill in "Repository Url" with ""
    Then I select "Staff approved" from "Status"
    And I press "Update App"
    And I should see "Repository url can't be blank"

Scenario: I can edit vetting app without URL
    Given I am on the edit app page for app id: "1"
    When I fill in "Repository Url" with ""
    When I fill in "App Name" with "BFX Dance"
    Then I select "Vetting pending" from "Status"
    And I press "Update App"
    Then I should see "App was successfully updated."

Scenario: I can update a vetting app to a non-vetting app with URL
    Given I am on the edit app page for app id: "1"
    Then I fill in "Repository Url" with "github.com/mynewapp"
    Then I select "Staff approved" from "Status"
    And I press "Update App"
    Then I should see "App was successfully updated."
