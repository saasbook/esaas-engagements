Feature: a user can be created

    As an admin user
    So that we can have a user associated with an org
    I want to create a user

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

    And I'm logged in on the orgs page

Scenario: There is a form on users page that I can use to create a user
    Given I am on the new user page
    Then I should see "New User"
    And I should see "User Name"
    And I should see "Email"
    And I should see "Preferred Contact"
    And I should see "GitHub Username"

Scenario: I can create a user
    Given I am on the new user page
    And I fill in the "New User" fields as follows:
        | field                     | value             |
        | user[name]                | user1             |
        | user[email]               | user1@gmail.com   |
        | user[preferred_contact]   | by email          |
        | user[github_uid]          | user1git          |
    And I press "Create User"
    Then I should see "User successfully created."

Scenario: I cannot submit with user name field blank
    Given I am on the new user page
    And I fill in the "New User" fields as follows:
        | field                     | value             |
        | user[email]               | user1@gmail.com   |
        | user[preferred_contact]   | by email          |
        | user[github_uid]          | user1git          |
    And I press "Create User"
    Then I should see "User Name can't be blank"

Scenario: I cannot submit with user name field blank
    Given I am on the new user page
    And I fill in the "New User" fields as follows:
        | field                     | value             |
        | user[name]                | user1             |
        | user[preferred_contact]   | by email          |
        | user[github_uid]          | user1git          |
    And I press "Create User"
    Then I should see "User E-mail address can't be blank"

Scenario: When I click back I go back to the users page
    Given I am on the new user page
    And I follow "Back"
    Then I am on the users page
