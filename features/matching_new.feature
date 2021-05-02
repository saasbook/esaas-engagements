Feature: Test Creating New Matching
    As a coach who need create matching for course
    I want to go to create new matching page
    So that I can create a new matching

Background: Users and apps have been added to database
    Given the following apps exist:
        | name | description | org_id | status  |
        | app1 | test        | 1      | pending |
        | app2 | test        | 1      | pending |
        | app3 | test        | 1      | pending |

    And the following users exist:
        | id | name  | github_uid      | email          | user_type |
        | 1  | user1 | esaas_developer | test@user.com  | coach     |
        | 2  | user2 |                 | test1@user.com | student   |
        | 3  | user3 |                 | test2@user.com | student     |

@javascript
Scenario: Coach can press new matching button
    Given I am on the login page
    And I follow "Log in with GitHub"
    And I am on the matching page
    And I should see "New Matching"
    And I click the button "New Matching"
    Then I should see hidden "Number of Engagements"
    Then I press hidden button "Next"
    
@javascript
Scenario: Coach can press new matching button
    Given I am on the login page
    And I follow "Log in with GitHub"
    And I am on the matching page
    Then I want to create matching with "1" engagements