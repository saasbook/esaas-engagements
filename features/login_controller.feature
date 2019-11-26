Feature: a call to "Login with Github" should redirect to the login page

  As a user who first opens the app
  So that I can efficiently browse the app and access the data
  I want to login with Github

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
        | name  | github_uid      | email         |
        | user1 | esaas_developer | test@user.com |
        | user2 |                 | test@user.com |
        | user3 |                 | test@user.com |

  And I am not logged in
  
Scenario: not logged in so should see login with Github from users page
  #Story ID: #152298585
  Given I am on the users page
  Then I should see "Log in with GitHub"
 
Scenario: not logged in so should see login with Github from orgs page 
  #Story ID: #152298585
  Given I am on the orgs page
  Then I should see "Log in with GitHub"
  
Scenario: not logged in so should see login with Github from create page 
  #Story ID: #152298585
  Given I am on the create page
  Then I should be on the login page

Scenario: not logged in so should not see "My Projects" tab
  Given I am on the home page
  And I am not logged in
  Then I should not see "My Projects"

Scenario: logged in so should see "My Projects" tab
  Given I am logged in
  Then I should see "My Projects"

Scenario: not logged in so should see "Login" tab
  Given I am not logged in
  Then I should see "Login"

  Scenario: logged in so should not see "Login" tab
    Given I am logged in
    Then I should not see "Login"