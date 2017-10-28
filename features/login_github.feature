Feature: after a user logins with their github id they are redirected to the page they wanted to view prior to login

  As a user who first opens the app
  So that I can efficiently login and browse the app
  I want to return to the page I requested to login

Background: users, orgs and apps have been added to database

  Given I am not logged in

Scenario: not logged in so should see login with Github from users page 
  Given I am on the users page
  Then I should see "Log in with GitHub"
 
Scenario: not logged in so should see login with Github from orgs page 
  Given I am on the orgs page
  Then I should see "Log in with GitHub"
  
Scenario: not logged in so should see login with Github from create page 
  Given I am on the create page
  Then I should see "Log in with GitHub"

Scenario: login with Github from orgs page and redirect to orgs
  Given I am on the apps page
  And I follow "Orgs"
  And I follow "Log in with GitHub"
  Then I should be on the orgs page
  
Scenario: login with Github from users page and redirect to users
  Given I am not logged in
  And I am on the apps page
  And I follow "Users"
  And I follow "Log in with GitHub"
  Then I should be on the users page

Scenario: login with Github from create page and redirect to create
  Given I follow "Create"
  And I follow "Log in with GitHub"
  Then I should be on the create page