
Feature: searching to quickly find apps according to their name/description
    As a logged out user
    So that I can see a list of apps
    I should be able to search the app in the app listing page by name/description

Background: Logged Out
    Given the following apps exist:
        | name   | description             | org_id | status  |
        | app 1  | this is one test        | 1      | pending |
        | app 2  | this is two test        | 2      | pending |
        | app 3  | this is three test      | 3      | pending |

    And the following orgs exist:
        | name  | contact_id |
        | org A | 1          |
        | org B | 1          |
        | org C | 1          |

    And the following users exist:
        | name  | github_uid      | email         |
        | user 1 | esaas_developer| test@user.com |
        | user 2 | esaas_client   | test@client.com |

    And I'm am on the root page

#Scenario: No keyword
    #Given I publicly search for ""
    #Then I should not see "app 1"


#Scenario: search for an app by name keyword
   # Given I publicly search for "1"
    #Then I should see "app 1"
   # But I should not see "app 2"
    #And I should not see "app 3"
