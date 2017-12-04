Feature: an org can be edited

    As an admin user
    So that we can update the org with correct information
    I want to edit an org

Background: Logged in
    And the following users exist:
        | id | name  | github_uid      | email          | user_type     |
        | 1  | user1 | esaas_developer | test@user.com  | coach         |
        | 2  | user2 |                 | test1@user.com | coach         |

    And the following orgs exist:
        | name | contact_id | id |
        | org1 | 1          | 1  |

    And I'm logged in on the orgs page
    Given I am on the edit org page for org id: "1"

Scenario: I can edit an org
    And I fill in the "Edit Org" fields as follows:
    | field                     | value             |
    | org[name]                 | new_org_name      |
    And I press "Update Org"
    Then I should see "Org was successfully updated."

Scenario: I cannot submit with org name field blank
    And I fill in the "Edit User" fields as follows:
        | field                     | value             |
        | org[name]                 |                   |
    And I press "Update Org"
    Then I should see "Org Name can't be blank"

