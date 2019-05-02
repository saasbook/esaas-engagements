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

Feature: a user can choose the number of orgs show in one page

    As an admin user
    In order to view numerous orgs easier
    I want to choose number of orgs in one page according to my favor

Background: Logged in
    Given the following orgs exist:
        | name  | description | org_id | status  |
        | app_1  | test        | 1      | pending |
        | app_2  | test        | 1      | pending |

    And the following orgs exist:
        | name | contact_id |
        | org_a | 1         |
        | org_b | 1         |
        | org_c | 1         |
        | org_d | 1         |
        | org_e | 1         |
        | org_f | 1         |
        | org_g | 1         |
        | org_h | 1         |
        | org_i | 1         |
        | org_j | 1         |
        | org_k | 1         |
        | org_l | 1         |



    And the following users exist:
        | id | name  | github_uid      | email          | user_type     |
        | 1  | user1 | esaas_developer | test@user.com  | coach         |

Scenario: There are some click buttons on orgs page that I can control the pagination
    Given I am on the orgs page
    Then I should see "10"
    And I should see "50"
    And I should see "100"
    And I should see "All"
    And I should see "First"
    And I should see "Previous"
    And I should see "Next"
    And I should see "Last"

Scenario: I can see all orgs with selection all
    Given I am on the orgs page
    When I follow "All"
    Then I should see "org_a"
    And I should see "org_b"
    And I should see "org_k"
    And I should see "org_l"

Scenario: I can press number buttons to do pagination
    Given I am on the orgs page
    When I follow "10"
    Then I should see "org_a"
    And I should see "org_b"
    And I should see "org_j"
    And I should not see "org_k"
    And I should not see "org_l"

Scenario: I can use "next" and "previous" buttons to see previous or next orgs
    Given I am on the orgs page
    When I follow "10"
    Then I should see "org_a"
    And I should see "org_b"
    And I should see "org_c"
    And I should see "org_d"
    And I should see "org_e"
    And I should see "org_f"
    And I should see "org_g"
    And I should see "org_h"
    And I should see "org_i"
    And I should see "org_j"
    And I should not see "org_k"
    And I should not see "org_l"
    When I follow "Next"
    Then I should not see "org_a"
    And I should not see "org_b"
    And I should not see "org_c"
    And I should not see "org_d"
    And I should not see "org_e"
    And I should not see "org_f"
    And I should not see "org_g"
    And I should not see "org_h"
    And I should not see "org_i"
    And I should not see "org_j"
    And I should not see "org_j"
    And I should see "org_k"
    And I should see "org_l"
    When I follow "Previous"
    Then I should see "org_a"
    And I should see "org_b"
    And I should see "org_c"
    And I should see "org_d"
    And I should see "org_e"
    And I should see "org_f"
    And I should see "org_g"
    And I should see "org_h"
    And I should see "org_i"
    And I should see "org_j"
    And I should not see "org_k"
    And I should not see "org_l"

Scenario: I can click "First" or "Last" to see the first page or last page of orgs
    Given I am on the orgs page
    When I follow "10"
    Then I should see "org_b"
    And I should not see "org_k"
    And I should not see "org_l"
    When I follow "Last"
    Then I should not see "org_j"
    And I should see "org_k"
    And I should see "org_l"
    When I follow "First"
    Then I should see "org_b"
    And I should not see "org_k"
    And I should not see "org_l"

Scenario: I cannot press previous in the very front page
    Given I am on the orgs page
    When I follow "All"
    And I follow "Previous"
    Then I should see "org_b"
    And I should see "You are already on the FIRST page."

Scenario: I cannot press previous in the very front page
    Given I am on the orgs page
    When I follow "All"
    And I follow "Next"
    Then I should see "org_k"
    When I follow "Next"
    Then I should see "org_k"
    And I should see "You are already on the LAST page."


Feature: a user can choose the number of users show in one page

    As an admin user
    In order to view numerous users easier
    I want to choose number of users in one page according to my favor
    
Background: Logged in
    Given the following users exist:
        | name  | description | user_id | status  |
        | app1  | test        | 1      | pending |
        | app2  | test        | 1      | pending |


    And the following users exist:
        | name | contact_id |
        | org1 | 1          |
        | org2 | 1          |

    And the following users exist:
        | id | name  | github_uid      | email          | user_type     |
        | 1  | user_a | esaas_developer | test@user.com  | coach         |
        | 2  | user_b | esaas_developer | test@user.com  | coach         |
        | 3  | user_c | esaas_developer | test@user.com  | coach         |
        | 4  | user_d | esaas_developer | test@user.com  | coach         |
        | 5  | user_e | esaas_developer | test@user.com  | coach         |
        | 6  | user_f | esaas_developer | test@user.com  | coach         |
        | 7  | user_g | esaas_developer | test@user.com  | coach         |
        | 8  | user_h | esaas_developer | test@user.com  | coach         |
        | 9  | user_i | esaas_developer | test@user.com  | coach         |
        | 10 | user_j | esaas_developer | test@user.com  | coach         |
        | 11 | user_k | esaas_developer | test@user.com  | coach         |
        | 12 | user_l | esaas_developer | test@user.com  | coach         |



Scenario: There are some click buttons on users page that I can control the pagination
    Given I am on the users page
    Then I should see "10"
    And I should see "50"
    And I should see "100"
    And I should see "All"
    And I should see "First"
    And I should see "Previous"
    And I should see "Next"
    And I should see "Last"

Scenario: I can see all users with selection all
    Given I am on the users page
    When I follow "All"
    Then I should see "user_a"
    And I should see "user_b"
    And I should see "user_k"
    And I should see "user_l"

Scenario: I can press number buttons to do pagination
    Given I am on the users page
    When I follow "10"
    Then I should see "user_a"
    And I should see "user_b"
    And I should see "user_j"
    And I should not see "user_k"
    And I should not see "user_l"

Scenario: I can use "next" and "previous" buttons to see previous or next users
    Given I am on the users page
    When I follow "10"
    Then I should see "user_a"
    And I should see "user_b"
    And I should see "user_c"
    And I should see "user_d"
    And I should see "user_e"
    And I should see "user_f"
    And I should see "user_g"
    And I should see "user_h"
    And I should see "user_i"
    And I should see "user_j"
    And I should not see "user_k"
    And I should not see "user_l"
    When I follow "Next"
    Then I should not see "user_a"
    And I should not see "user_b"
    And I should not see "user_c"
    And I should not see "user_d"
    And I should not see "user_e"
    And I should not see "user_f"
    And I should not see "user_g"
    And I should not see "user_h"
    And I should not see "user_i"
    And I should not see "user_j"
    And I should not see "user_j"
    And I should see "user_k"
    And I should see "user_l"
    When I follow "Previous"
    Then I should see "user_a"
    And I should see "user_b"
    And I should see "user_c"
    And I should see "user_d"
    And I should see "user_e"
    And I should see "user_f"
    And I should see "user_g"
    And I should see "user_h"
    And I should see "user_i"
    And I should see "user_j"
    And I should not see "user_k"
    And I should not see "user_l"

Scenario: I can click "First" or "Last" to see the first page or last page of users
    Given I am on the users page
    When I follow "10"
    Then I should see "user_b"
    And I should not see "user_k"
    And I should not see "user_l"
    When I follow "Last"
    Then I should not see "user_j"
    And I should see "user_k"
    And I should see "user_l"
    When I follow "First"
    Then I should see "user_b"
    And I should not see "user_k"
    And I should not see "user_l"

Scenario: I cannot press previous in the very front page
    Given I am on the users page
    When I follow "All"
    And I follow "Previous"
    Then I should see "user_b"
    And I should see "You are already on the FIRST page."

Scenario: I cannot press previous in the very front page
    Given I am on the users page
    When I follow "All"
    And I follow "Next"
    Then I should see "user_k"
    When I follow "Next"
    Then I should see "user_k"
    And I should see "You are already on the LAST page."
