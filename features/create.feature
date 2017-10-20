Feature: create a new app, user, and organization all at once

    As an admin user
    So that I can quickly create an app, user, organization
    I want to create everything on one page

<<<<<<< HEAD
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
        | name  | github_uid      | email         |
        | user1 | esaas_developer | test@user.com |
        | user2 |                 | test@user.com |
        | user3 |                 | test@user.com |
    
    And I'm logged in on the orgs page

Scenario: An admin user can visit the create tab
    And I follow "Create"
    Then I should be on the create page

Scenario: If you're not logged in and you click on the create tab, there should be an option to log in as admin
    Given I am not logged in
    And I follow "Create"
    Then I should see "Log in with GitHub"

Scenario: User cannot submit if form is incomplete
    Given I fill in the "User Information" fields as follows:
        | User Name        | Fakeuser               |
    And I fill in the "Org Information" fields as follows:
        | Phone            | 555-555-5555           |
        | Description      | ESAAS Engagement Group |
        | url              | https://google.com     |
        | Comments         | Hi                     |
    And I fill in the "App Information" fields as follows:
      	| User             | Fake app name          |
	And I press "Submit"
	Then creation should fail with "Email can't be blank"

Scenario: User can submit successfully if form is complete
    Given I fill in the "User Information" fields as follows:
        | User Name           | Fakeuser              |
        | Email               | fakeuser@berkeley.edu |
        | Preferred Contact   | 555-555-5555          |
        | Github uid          | fakegithubuid         |
    And I fill in the "Org Information" fields as follows:
        | Organization Name   | Group 20               |
        | Address Line 1      | 2000 Durant            |
        | City State Zip      | Berkeley, CA 55555     |
        | Phone               | 555-555-5555           |
        | Description         | ESAAS Engagement Group |
        | url                 | https://google.com     |
        | Comments            | Hi                     |
        | Defunct             | uncheck                |
    And I fill in the "App Information" fields as follows:
        | App Name       	 | Fake app      	        |
    	| Description        | Fake app description     |
    	| Deployment url     | Fake app deployment url  |
    	| Repository url     | Fake app repository      |
    	| CodeClimate url    | Fake app codeclimate url |
        | Comments           | Fake app status          |
    	| App Status         | Fake app status          |
    And I press "Submit"
    Then I should be on the app page for the app "fake_app"

Scenario: User can clear the form
    Given I fill in "User Name" with "Some Name"
    And I press "Clear"
    Then I should see an empty form
