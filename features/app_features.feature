Feature: processing initial feature with apps
   As a staff who uses the app
   I want each app has initial features
   So that I can easily see feature for an app

Background: Logged in
   Given the following apps exist:
       | name  | description | org_id | status  | features        |
       | app1  | test        | 1      | pending | NEED FEATURES!! |
       | app2  | test        | 1      | pending |                 |
       | app3  | test        | 1      | pending |                 |

    # And the following engagements exist:
    #     | id | app_id | coach_id | team_number | start_date | student_names       | features |
    #     | 1  | 1      | 1        | 1           | 2017-10-01 | fake1, fake2, fake3 | Adding feature boxes |

    # And the following iterations exist:
    #     | id | engagement_id | end_date   | customer_feedback |
    #     | 1  | 1             | 2017-10-26 |                   |

    And the following orgs exist:
       | name | contact_id |
       | org1 | 1          |
       | org2 | 1          |
       | org3 | 1          |

   And the following users exist:
       | id | name  | github_uid      | email          | user_type     |
       | 1  | user1 | esaas_developer | test@user.com  | coach         |
       | 2  | user2 |                 | test1@user.com | student       |
       | 3  | user3 |                 | test2@user.com | client        |
       | 4  | user4 |                 | test4@user.com | client        |


   And I'm logged in on the orgs page
   And I follow "Apps"



# Story ID: 1929857751
Scenario: A user can see initial features for each app on App's detail page
    Given I follow "app1"
    Then I should see "App Initial Features"
    And I should see "NEED FEATURES!!"

# Story ID: 1929857752
Scenario: A user can add initial features while creating apps
    Given I follow "New App"
    When I fill in "App Name" with "Fake app"
    When I fill in "App Description" with "Fake app description"
    When I fill in "App Initial Features" with "Fake app features"
    And I press "Create App"
    And I follow "Fake app"
    Then I should see "App Initial Features"
    And I should see "Fake app features"

# Story ID: 1929857753
Scenario: A user can add initial features while editing apps
   Given I follow "app1"
   And I follow "Edit App"
   When I fill in "App Initial Features" with "app1 features"
   And I press "Update App"
   And I follow "app1"
   Then I should see "App Initial Features"
   And I should see "app1 features"

# Testing pivotal tracker url in app create
Scenario: A user can add pivotal tracker url while creating apps
   Given I follow "New App"
   When I fill in "App Name" with "Pivotal tracker app"
   And I fill in "App Description" with "App with pivotal tracker url"
   And I fill in "Pivotal Tracker Url" with "https://www.pivotaltracker.com/12345"
   And I press "Create App"
   And I follow "Pivotal tracker app"
   Then I should see "Pivotal Tracker"
   And I should see "https://www.pivotaltracker.com/12345"

# Testing pivotal tracker url in app edit
Scenario: A user can add pivotal tracker url while editing apps
   Given I follow "app1"
   And I follow "Edit App"
   When I fill in "Pivotal Tracker Url" with "https://www.pivotaltracker.com/12345"
   And I press "Update App"
   And I follow "app1"
   Then I should see "Pivotal Tracker"
   And I should see "https://www.pivotaltracker.com/12345"
