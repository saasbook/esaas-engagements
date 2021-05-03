Feature: Test Creating New Matching
    As a coach who need create matching for course
    I want to go to create new matching page
    So that I can create a new matching

Background: Users and apps have been added to database
    Given the following apps exist:
        | name | description | org_id | status  |
        | App1 | test        | 1      | pending |
        | App2 | test        | 1      | pending |
        | App3 | test        | 1      | pending |
        | App4 | test        | 1      | pending |

    And the following users exist:
        | id | name  | github_uid      | email          | user_type |
        | 1  | user1 | esaas_developer | test@user.com  | coach     |
        | 2  | user2 |                 | test1@user.com | student   |
        | 3  | user3 |                 | test2@user.com | student   |
@javascript
Scenario: Coach can press new matching button
    Given I am on the login page
    And I follow "Log in with GitHub"
    And I am on the matching page
    And I should see "New Matching"
    And I click the button "New Matching"
    Then I should see hidden "Number of Engagements"
    
@javascript
Scenario: Coach can create new matching
    Given I am on the login page
    And I follow "Log in with GitHub"
    And I am on the matching page
    Then I want to create matching with "2" engagements
    Then I fill in "Matching Name" with "Matching 1"
    And I select "App1" from "App Names"
    And I select "App2" from "App Names"
    And I fill in "1) Team Number/Name" with "Team1"
    And I select "user2" from "1) Students"
    And I fill in "2) Team Number/Name" with "Team2"
    And I select "user3" from "2) Students"
    And I press "Submit"
    Then I should see "Matching 1"
    Then I visit "/matching"

@javascript
Scenario: Coach cannot create new matching with 0 engagement (sad)
    Given I am on the login page
    And I follow "Log in with GitHub"
    And I am on the matching page
    Then I want to create matching with "0" engagements
    Then I should see "Number of engagements needs to be at least one."
    Then I visit "/matching"

@javascript
Scenario: Coach can delete a matching
    Given I am on the login page
    And I follow "Log in with GitHub"
    And I am on the matching page
    Then I want to create matching with "2" engagements
    Then I fill in "Matching Name" with "Matching 1"
    And I select "App1" from "App Names"
    And I select "App2" from "App Names"
    And I fill in "1) Team Number/Name" with "Team1"
    And I select "user2" from "1) Students"
    And I fill in "2) Team Number/Name" with "Team2"
    And I select "user3" from "2) Students"
    And I press "Submit"
    Then I should see "Matching 1"
    Then I should see "Delete"
    And I click the delay delete button "Delete"
    Then I should see "Are you sure to delete Matching 1?"
    Then I should see "Delete"
    Then I follow "Delete"
    And I should not see "Matching 1"
    Then I visit "/matching"
    

@javascript
Scenario: Non-Coach without access cannot visit matching page
    Given I am not logged in
    And I visit "/matching"
    Then I should not see "Project Matchings"
    Then I visit "/matching"

@javascript
Scenario: Coach need to fill out all field to create new matching
    Given I am on the login page
    And I follow "Log in with GitHub"
    And I am on the matching page
    Then I want to create matching with "2" engagements
    Then I fill in "Matching Name" with "Matching 1"
    And I press "Submit"
    Then I should not see "Matching 1"
    Then I should see "Number of engagements needs to be at least one."
    Then I visit "/matching"