Feature: a user can be edited
    
    As an admin user
    So that we can update the user with correct information
    I want to edit a user

Background: Logged in
    And the following users exist:
        | name  | github_uid      | email         | id |
        | user1 | esaas_developer | test@user.com | 1  |

    And I'm logged in on the orgs page
    Given I am on the edit user page for user id: "1"

Scenario: There is a form on the edit user page
    Then I should see "Edit User"
    And I should see "User Name"
    And I should see "User E-mail address"
    And I should see "Preferred contact"
    And I should see "Github uid"

Scenario: I can edit a user
    And I fill in the "Edit User" fields as follows:
        | field                     | value             |
        | user[name]                | user1             |
        | user[email]               | user1@gmail.com   |
        | user[preferred_contact]   | by email          |
        | user[github_uid]          | user1git          |
    And I press "Save"
    Then I should see "User was successfully updated."

Scenario: I cannot submit with user name field blank
    And I fill in the "Edit User" fields as follows:
        | field                     | value             |
        | user[name]                |                   |
        | user[email]               | user1@gmail.com   |
        | user[preferred_contact]   | by email          |
        | user[github_uid]          | user1git          |
    And I press "Save"
    Then I should see "User Name can't be blank"

Scenario: I cannot submit with user name field blank
    And I fill in the "Edit User" fields as follows:
        | field                     | value             |
        | user[name]                | user1             |
        | user[email]               |                   |
        | user[preferred_contact]   | by email          |
        | user[github_uid]          | user1git          |
    And I press "Save"
    Then I should see "User E-mail address can't be blank"

Scenario: When I click back I go back to the users page
    And I follow "Back"
    Then I am on the users page


