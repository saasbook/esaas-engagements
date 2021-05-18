Feature: Test Matching finalizing page feature
    As a coach who created matching 1
    I want to get result of matching after everyone gives responses
    So that I know the matching result


Background: Users and apps have been added to database
    Given the following apps exist:
        | name | description | org_id | status  |
        | App1 | test        | 1      | pending |
        | App2 | test        | 1      | pending |

    And the following users exist:
        | id | name  | github_uid      | email          | user_type |
        | 1  | user1 | esaas_developer | test@user.com  | coach     |
        | 2  | user2 |                 | test1@user.com | student   |
        | 3  | user3 |                 | test2@user.com | student   |