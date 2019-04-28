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

Scenario: Updating the status of an app to deployment category without repo URL should fail
    #Story ID: #165265798
    Given I am on the edit app page for app id: "1"
    When I fill in "Repository Url" with ""
    And I select "In use" from "Status"
    And I press "Update App"
    Then I should see "Repository url can't be blank"

Scenario: Edit an app in vetting category without specifying repo URL
    #Story ID: #165265798
    Given I am on the edit app page for app id: "1"
    When I fill in "Repository Url" with ""
    And I fill in "App Name" with "BFX Dance"
    And I select "On hold" from "Status"
    And I press "Update App"
    Then I should see "App was successfully updated."

Scenario: Updating the status of an app to deployment category with repo URL should succeed
    #Story ID: #165265798
    Given I am on the edit app page for app id: "1"
    When I fill in "Repository Url" with "https://github.com/mynewapp"
    And I select "Staff approved" from "Status"
    And I press "Update App"
    Then I should see "App was successfully updated."