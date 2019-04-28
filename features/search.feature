
Feature: searching to quickly find apps according to name/organization/description
    As a logged in user
    So that I can quickly find the app I'm looking for
    I should be able to search the app in the app listing page by name/organization/description

Background: Logged in
    Given the following apps exist:
        | name   | description             | org_id | status  |
        | app 1  | this is one test        | 1      | pending |
        | app 2  | this is two test        | 2      | pending |
        | app 3  | this is three test      | 3      | pending |

    And the following orgs exist:
        | name  | contact_id |
        | org A | 1          |
        | org B | 1          |
        | org C | 1          |

    And the following users exist:
        | name  | github_uid      | email         |
        | user 1 | esaas_developer| test@user.com |

    And I'm logged in on the orgs page 

@javascript
Scenario: No keyword
    Given I search for ""
    Then I should see "app 1"
    And I should see "user 1"
    And I should see "org A"
    And I should see "Please enter a keyword in the search box."

Scenario: No filter
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Users"
    And I search for "1"
    Then I should not see "org A"
    And I should not see "user 1"
    And I should not see "app 1"
    And I should see "Please at least choose one category you want to search."

Scenario: search for an app by name keyword
    Given I uncheck "Users"
    And I search for "1"
    Then I should see "app 1"
    But I should not see "app 2"
    And I should not see "app 3"
    And I should not see "user 1"

    Given I search for "app"
    Then I should see "app 1"
    And I should see "app 2"
    And I should see "app 3"


Scenario: search for an app by description keyword
    Given I check "Organizations"
    And I search for "three"
    Then I should see "app 3"
    But I should not see "app 1"
    And I should not see "app 2"

    Given I search for "test"
    Then I should see "app 1"
    And I should see "app 2"
    And I should see "app 3"

Scenario: search for an organization by keyword
    Given I search for "org"
    Then I should see "org A"
    And I should see "org B"
    And I should see "org C"

    Given I search for "B"
    Then I should see "org B"
    But I should not see "org A"
    And I should not see "org C"



Scenario: search for an user by keyword
    Given I search for "user"
    Then I should see "user 1"

    Given I search for "1"
    And I uncheck "Organization"
    And I uncheck "App"
    Then I should see "user 1"


Scenario: search for all three categories by keyword
    Given I search for "1"
    Then I should see "app 1"
    And I should see "user 1"