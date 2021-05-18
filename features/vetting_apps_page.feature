Feature: ability to filter for vetting status on apps page (not testing the actual filting feature)

    As an admin user
    So that we can filter apps by (vetting) status
    I want to use filter on apps page

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
        | id | name  | github_uid      | email          | user_type     |
        | 1  | user1 | esaas_developer | test@user.com  | coach         |
        | 2  | user2 |                 | test1@user.com | student       |
        | 3  | user3 |                 | test2@user.com | coach         |

    # And I'm logged in on the apps page

Scenario: There is a form on users page that I can use to create a user
    Given I am on the apps page
    And I follow "Log in with GitHub"
    Then I should see "Vetting pending"
    And I should see "On hold"
    And I should see "Staff approved"
    And I should see "Customer informed"
    And I should see "Customer confirmation received"
    And I should see "Declined by staff "
    And I should see "Declined by customer"
    And I should see "Declined by customer available next sem"
    And I should see "Back up"

# Check directly on app to see if the filter works well. Checking js file is not working for features currently.