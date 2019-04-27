Feature: a user can choose the number of apps show in one page

    As an admin user
    In order to view numerous apps easier
    I want to choose number of apps in one page according to my favor

Background: Logged in
    Given the following apps exist:
        | name  | description | org_id | status  |
        | app1  | test        | 1      | pending |
        | app2  | test        | 1      | pending |
        | app3  | test        | 1      | pending |
        | app4  | test        | 1      | pending |
        | app5  | test        | 1      | pending |
        | app6  | test        | 1      | pending |
        | app7  | test        | 1      | pending |
        | app8  | test        | 1      | pending |
        | app9  | test        | 1      | pending |
        | app10  | test        | 1      | pending |
        | app11  | test        | 1      | pending |

    And the following orgs exist:
        | name | contact_id |
        | org1 | 1          |

    And the following users exist:
        | id | name  | github_uid      | email          | user_type     |
        | 1  | user1 | esaas_developer | test@user.com  | coach         |

Scenario: There are some click buttons on apps page that I can control the pagination
    Given I am on the apps page
    Then I should see "10"
    And I should see "50"
    And I should see "100"
    And I should see "All"
    And I should see "First"
    And I should see "Previous"
    And I should see "Next"
    And I should see "Last"

Scenario: I can see all apps with selection all
    Given I am on the apps page
    When I follow "All"
    Then I should see "app1"
    Then I should see "app2"
    Then I should see "app11"

Scenario: I can press number buttons to do pagination
    Given I am on the apps page
    When I follow "10"
    Then I should see "app1"
    Then I should see "app2"
    Then I should see "app10"
    Then I should not see "app11"

Scenario: I can use "next" and "previous" buttons to see previous or next apps
    Given I am on the apps page
    When I follow "10"
    Then I should see "app2"
    Then I should not see "app11"
    When I follow "Next"
    Then I should not see "app10"
    Then I should see "app11"
    When I follow "Previous"
    Then I should see "app2"
    Then I should not see "app11"

Scenario: I can click "First" or "Last" to see the first page or last page of apps
    Given I am on the apps page
    When I follow "10"
    Then I should see "app2"
    Then I should not see "app11"
    When I follow "Last"
    Then I should not see "app10"
    Then I should see "app11"
    When I follow "First"
    Then I should see "app2"
    Then I should not see "app11"

Scenario: I cannot press previous in the very front page
    Given I am on the apps page
    When I follow "All"
    When I follow "Previous"
    Then I should see "app2"
    Then I should see "You are already on the FIRST page."

Scenario: I cannot press previous in the very front page
    Given I am on the apps page
    When I follow "All"
    When I follow "Next"
    Then I should see "app11"
    When I follow "Next"
    Then I should see "app11"
    Then I should see "You are already on the LAST page."
