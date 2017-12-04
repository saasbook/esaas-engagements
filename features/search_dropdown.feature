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
        | name              | id | github_uid      | email          | user_type |
        | user1             | 1  | esaas_developer | test1@user.com | coach     |

  And I'm logged in on the orgs page

@javascript
Scenario: I can search the dropdown list of orgs on new app page
  # Story ID: 153069853
  Given I am on the new app page
  And I click "#select2-app_org_id-container"
  And I type in "org" in ".select2-search__field"
  Then I should see "org3" inside ".select2-results"
  And I should see "org4" inside ".select2-results"

@javascript
Scenario: I can still create a new app as usual
  # Story ID: 153069853
  Given I am on the new app page
  When I fill in "App Name" with "Fake app"
  When I fill in "App Description" with "Fake app description"
  When I fill in "Repository Url" with "http://fakeapp.com"
  And I click "#select2-app_org_id-container"
  And I type in "org" in ".select2-search__field"
  And I press enter in ".select2-search__field"
  And I press "Create App"
  Then I should be on the apps page
  And I should see "App was successfully created."