@wip
Feature: when creating an app, the orgs dropdown should be searchable
As a user of the app
So that I do not have to look through a long list of dropdown menu
I want to do a string matching within the dropdown menu

Background: user and orgs have been added to database
  And the following orgs exist:
        | id | name     | contact_id |
        | 1  | Berkeley | 1          |
        | 2  | Stanford | 1          |
        | 3  | org3     | 1          |
        | 4  | org4     | 1          |

  And the following users exist:
        | name  | github_uid      | email         |
        | user1 | esaas_developer | test@user.com |

  And I'm logged in on the orgs page
  
Scenario: I can search the dropdown list of orgs
  # Story ID: 153069853
  Given I am on the new app page
  And I fill in "organization" with "org"
  Then I should see "org3"
  And I should see "org4"