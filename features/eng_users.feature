Feature: engagement owns users working on that project / app
    As a staff who uses the app
    I want each engagement links to User objects
    So that I can easily assign students to an app
  
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
        | name  | github_uid      | email         | type     | SID    |
        | user1 | esaas_developer | test@user.com | Staff    |        |
        | user2 |                 | test@user.com | Student  | 1      |
        | user3 |                 | test@user.com | Student  | 2      |


    And I'm logged in on the orgs page
    And I follow "Apps"
    
Scenario: Can create a User with a type student or staff on new users form:
    Given I follow "app1"
    And I press "New&hellip;"
    Then I should see "Member 1"
    And I should see "Member 2"
    And I should see "Member 3"
    And I should see "Member 4"
    And I should see "Member 5"
    And I should see "Member 6"
