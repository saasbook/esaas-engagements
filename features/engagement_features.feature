Feature: processing feature with engagements
   As a staff who uses the app
   I want each engagement has individual features
   So that I can easily see feature for engagement to an app

Background: Logged in
   Given the following apps exist:
       | name  | description | org_id | status  |
       | app1  | test        | 1      | pending |
       | app2  | test        | 1      | pending |
       | app3  | test        | 1      | pending |

    And the following engagements exist:
        | id | app_id | coach_id | team_number | start_date | student_names       | features |
        | 1  | 1      | 1        | 1           | 2017-10-01 | fake1, fake2, fake3 | Adding feature boxes |

    And the following iterations exist:
        | id | engagement_id | end_date   | customer_feedback |
        | 1  | 1             | 2017-10-26 |                   |

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



# Story ID: 1529857751
Scenario: A user can see features for each engagement on App's detail page
    Given I follow "app1"
    Then I should see "Features"
    And I should see "Adding feature boxes"

# Story ID: 1529857751
Scenario: A user can add features while creating engagement
   Given I follow "app1"
   And I create a new engagement for "app1"
   When I fill in the engagement fields as follows:
       | field                  | value             |
       | Team Number            | Team1             |
       | Features               | more features!!   |
   And I press "Create Engagement"
   Then I should see "Engagement was successfully created."
   And I should see "more features!!" 