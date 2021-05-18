Feature: after a user logins with their github id they can create an app or modify and destroy and existing app

  As a user who first opens the app
  So that I can efficiently create, edit or destroy an app
  I want to return to the apps page I requested to login

Background: users, orgs and apps have been added to database
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

  And I am not logged in

Scenario: Login to github to create a new app
  #Story ID: #152298585
  Given I am not logged in
  And I am on the login page
  And I follow "Log in with GitHub"
  And I am on the apps page
  And I follow "New App"
  And I am on the new_app page
  And I press "Create App"
  And I should see "2 errors prohibited App from being saved:"
  And I should see "App Name can't be blank"
  And I should see "App Description can't be blank"
  When I fill in "App Name" with "Fake app"
  When I fill in "App Description" with "Fake app description "
  When I fill in "Deployment Url" with "http://fakeapp.com"
  When I fill in "Repository Url" with "http://fakerepo.com"
  And I press "Create App"
  Then I should be on the apps page
  And I should see "App was successfully created."

Scenario: Login to github to create a new app in vetting status
  #Story ID: #165265798
  Given I am not logged in
  And I am on the login page
  And I follow "Log in with GitHub"
  And I am on the apps page
  And I follow "New App"
  And I am on the new_app page
  And I select "Vetting pending" from "Status"
  And I press "Create App"
  And I should see "2 errors prohibited App from being saved:"
  And I should see "App Name can't be blank"
  And I should see "App Description can't be blank"
  When I fill in "App Name" with "Fake app"
  When I fill in "App Description" with "Fake app description "
  When I fill in "Deployment Url" with "http://fakeapp.com"
  And I press "Create App"
  Then I should be on the apps page
  And I should see "App was successfully created."

  Scenario: Login to github to see a app detail with its status
    Given I am not logged in
    And I am on the login page
    And I follow "Log in with GitHub"
    And I am on the apps page
    And I follow "app1"
    Then I should see "Status: pending"

Scenario: Login to github to create a new app in non-pending deployment status
  #Story ID: #165265798
  Given I am not logged in
  And I am on the login page
  And I follow "Log in with GitHub"
  And I am on the apps page
  And I follow "New App"
  And I am on the new_app page
  And I select "Development" from "Status"
  And I press "Create App"
  And I should see "3 errors prohibited App from being saved:"
  And I should see "App Name can't be blank"
  And I should see "App Description can't be blank"
  And I should see "Repository url can't be blank"
  When I fill in "App Name" with "Fake app"
  When I fill in "App Description" with "Fake app description "
  When I fill in "Deployment Url" with "http://fakeapp.com"
  When I fill in "Repository Url" with "http://fakerepo.com"
  And I press "Create App"
  Then I should be on the apps page
  And I should see "App was successfully created."

Scenario: Login to github to edit an existing app successfully
  #Story ID: #152298585
  Given I am not logged in
  And I am on the login page
  And I follow "Log in with GitHub"
  And I am on the apps page
  And I want to edit "app1"
  And I should see "Editing App"
  When I fill in "App Name" with "Fake app"
  When I fill in "App Description" with "Fake app description "
  When I fill in "Deployment Url" with "http://fakeapp.com"
  When I fill in "Repository Url" with "http://fakerepo.com"
  And I press "Update App"
  Then I should be on the apps page
  And I should see "App was successfully updated."

Scenario: Login to github to falsely edit an existing app
  #Story ID: #152298585
  Given I am not logged in
  And I am on the login page
  And I follow "Log in with GitHub"
  And I am on the apps page
  And I want to edit "app1"
  And I should see "Editing App"
  When I fill in "App Name" with ""
  And I press "Update App"
  And I should see "App Name can't be blank"

Scenario: Login to github to delete an existing app successfully
  #Story ID: #152298585
  Given I am not logged in
  And I am on the login page
  And I follow "Log in with GitHub"
  And I am on the apps page
  And I want to destroy "app1"
  Then I should see "App was successfully destroyed."
  And I am on the apps page
