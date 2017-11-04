Feature: Have User support Student and Staff types
    As a developer
    So that I can differentiate between student and staff among Users
    I want Users to be categorized into types
    #Story ID: #152298593

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
        | name  | github_uid      | email          |
        | user1 | esaas_developer | test1@user.com |
        | user2 |                 | test2@user.com |
        | user3 |                 | test3@user.com |

    And I'm logged in on the orgs page
    And I follow "Users"

Scenario: Can create a User with a type: student or staff:
  #Story ID: #152298593
  Given I follow "New User"
  Then I should see "Type"
  And I should see "SID"

Scenario: Users page should display type and id information:
  #Story ID: #152298593
  Then I should see "Type"
  And I should see "SID"

Scenario: Can create a User as a student with SID:
  #Story ID: #152298593
  Given I follow "New User"
  When I fill in the fields as follows:
    | field               | value      |
    | User Name           | fake name  |
    | User E-mail address | fake addr  |
    | Type of user        | Student    |
    | SID                 | 11111111   |
  And I press "Save"
  And I should be on the users page
  And I should see "fake name" has type "Student"
  And I should see "fake name" has SID "11111111"

Scenario: Can create a User that is a Staff:
  #Story ID: #152298593
  Given I follow "New User"
  When I fill in the fields as follows:
    | field                  | value      |
    | User Name              | fake name  |
    | User E-mail address    | fake addr  |
    | Type of user           | Staff      |
  And I press "Save"
  And I should be on the users page
  And I should see "fake name" has type "Staff"

Scenario: Edit form for Users has Type and SID fields:
  #Story ID: #152298593
  Given I press "Edit" for "user2"
  Then I should see "Edit User"
  And I should see "Type"
  And I should see "SID"

Scenario: Can edit Users to add Type and SID:
  #Story ID: #152298593
  Given I press "Edit" for "user2"
  And I should see "Edit User"
  When I fill in the fields as follows:
    | field                  | value      |
    | Type of user           | Staff      |
    | SID                    | 0          |
  And I press "Save"
  And I should be on the users page
  And I should see "user2" has type "Staff"
  And I should see "user2" has SID "0"

# Add tests for create

Scenario: User can submit a create form that includes user type and SID for Student
  #Story ID: #152298593
  And I follow "Create"
  Given I fill in the "User Information" fields as follows:
    | field               | value                 |
    | User Name           | Fakeuser              |
    | Email               | fakeuser@berkeley.edu |
    | Preferred Contact   | 555-555-5555          |
    | Github uid          | fakegithubuid         |
    | Type of user        | Student               |
    | SID                 | 11111111              |
  And I fill in the "Org Information" fields as follows:
    | field                     | value                  |
    | Organization Name         | Group 20               |
    | Address Line 1            | 2000 Durant            |
    | City State Zip            | Berkeley, CA 55555     |
    | Phone                     | 555-555-5555           |
    | Organization Description  | ESAAS Engagement Group |
    | url                       | https://google.com     |
    | Organization Comments     | Hi                     |
  And I fill in the "App Information" fields as follows:
    | field              | value                    |
    | App Name            | Fake app                  |
    | App Description    | Fake app description     |
    | Deployment url     | Fake app deployment url  |
    | Repository url     | Fake app repository      |
    | Code Climate url   | Fake app codeclimate url |
  And I press "Submit"
  Then I should be on the app details page for "Fake app"
  Then I should see "User, Org, and App were successfully created"

Scenario: User can submit a create form that includes user type and SID for Staff
  #Story ID: #152298593
  And I follow "Create"
  Given I fill in the "User Information" fields as follows:
    | field               | value                 |
    | User Name           | Professor              |
    | Email               | professor@berkeley.edu |
    | Preferred Contact   | 555-555-5555          |
    | Github uid          | fakegithubuid         |
    | Type of user        | Staff               |
    | SID                 | 222222              |
  And I fill in the "Org Information" fields as follows:
    | field                     | value                  |
    | Organization Name         | Group 20               |
    | Address Line 1            | 2000 Durant            |
    | City State Zip            | Berkeley, CA 55555     |
    | Phone                     | 555-555-5555           |
    | Organization Description  | ESAAS Engagement Group |
    | url                       | https://google.com     |
    | Organization Comments     | Hi                     |
  And I fill in the "App Information" fields as follows:
    | field              | value                    |
    | App Name            | Fake app                  |
    | App Description    | Fake app description     |
    | Deployment url     | Fake app deployment url  |
    | Repository url     | Fake app repository      |
    | Code Climate url   | Fake app codeclimate url |
  And I press "Submit"
  Then I should be on the app details page for "Fake app"
  Then I should see "User, Org, and App were successfully created"