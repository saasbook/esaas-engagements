Feature: a user can choose the number of apps show in one page

    As an admin user
    In order to view numerous apps easier
    I want to choose number of apps in one page according to my favor

Background: Logged in
    Given the following apps exist:
        | name  | description | org_id | status  |
        | app_a  | test        | 1      | pending |
        | app_b  | test        | 1      | pending |
        | app_c  | test        | 1      | pending |
        | app_d  | test        | 1      | pending |
        | app_e  | test        | 1      | pending |
        | app_f  | test        | 1      | pending |
        | app_g  | test        | 1      | pending |
        | app_h  | test        | 1      | pending |
        | app_i  | test        | 1      | pending |
        | app_j  | test        | 1      | pending |
        | app_k  | test        | 1      | pending |
        | app_l  | test        | 2      | vetting_pending |

    And the following orgs exist:
        | name | contact_id |
        | org1 | 1          |
        | org2 | 1          |

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
    Then I should see "app_a"
    And I should see "app_b"
    And I should see "app_k"
    And I should see "app_l"

Scenario: I can press number buttons to do pagination
    Given I am on the apps page
    When I follow "10"
    Then I should see "app_a"
    And I should see "app_b"
    And I should see "app_j"
    And I should not see "app_k"
    And I should not see "app_l"

Scenario: I can use "next" and "previous" buttons to see previous or next apps
    Given I am on the apps page
    When I follow "10"
    Then I should see "app_a"
    And I should see "app_b"
    And I should see "app_c"
    And I should see "app_d"
    And I should see "app_e"
    And I should see "app_f"
    And I should see "app_g"
    And I should see "app_h"
    And I should see "app_i"
    And I should see "app_j"
    And I should not see "app_k"
    And I should not see "app_l"
    When I follow "Next"
    Then I should not see "app_a"
    And I should not see "app_b"
    And I should not see "app_c"
    And I should not see "app_d"
    And I should not see "app_e"
    And I should not see "app_f"
    And I should not see "app_g"
    And I should not see "app_h"
    And I should not see "app_i"
    And I should not see "app_j"
    And I should not see "app_j"
    And I should see "app_k"
    And I should see "app_l"
    When I follow "Previous"
    Then I should see "app_a"
    And I should see "app_b"
    And I should see "app_c"
    And I should see "app_d"
    And I should see "app_e"
    And I should see "app_f"
    And I should see "app_g"
    And I should see "app_h"
    And I should see "app_i"
    And I should see "app_j"
    And I should not see "app_k"
    And I should not see "app_l"

Scenario: I can click "First" or "Last" to see the first page or last page of apps
    Given I am on the apps page
    When I follow "10"
    Then I should see "app_b"
    And I should not see "app_k"
    And I should not see "app_l"
    When I follow "Last"
    Then I should not see "app_j"
    And I should see "app_k"
    And I should see "app_l"
    When I follow "First"
    Then I should see "app_b"
    And I should not see "app_k"
    And I should not see "app_l"

Scenario: I cannot press previous in the very front page
    Given I am on the apps page
    When I follow "All"
    And I follow "Previous"
    Then I should see "app_b"
    And I should see "You are already on the FIRST page."

Scenario: I cannot press previous in the very front page
    Given I am on the apps page
    When I follow "All"
    And I follow "Next"
    Then I should see "app_k"
    When I follow "Next" 
    Then I should see "app_k"
    And I should see "You are already on the LAST page."
