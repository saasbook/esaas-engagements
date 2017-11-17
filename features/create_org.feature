Feature: an org can be created

    As an admin user
    So that we can have an org associated with an app
    I want to create an org

Background: Logged in
    And the following users exist:
        | name  | github_uid      | email         |
        | user1 | esaas_developer | test@user.com |

    And I'm logged in on the orgs page
    Given I am on the new org page

Scenario: There is a form on the orgs page
    Then I should see "New Organization"
    And I should see "Org Name"
    And I should see "Address line 1"
    And I should see "Address line 2"
    And I should see "City state zip"
    And I should see "Phone"
    And I should see "Description"
    And I should see "Url"
    And I should see "Defunct"
    And I should see "Contact"

Scenario: I can create an org
    And I fill in the "New Organization" fields as follows:
        | field                     | value             |
        | org[name]                 | org1              |
    And I press "Save"
    Then I should see "Org was successfully created."

Scenario: I cannot submit with org name field blank
    And I fill in the "New Organization" fields as follows:
        | field                     | value             |
        | org[name]                 |                   |
    And I press "Save"
    Then I should see "Org Name can't be blank"

