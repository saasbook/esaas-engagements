Feature: Adding "semester" field for start date record
    As an authorized user
    So that I can check the project details
    I want to see the start semester of some projects

Background: Logged in
   Given the following apps exist:
       | name  | description | org_id | status  |
       | app1  | test        | 1      | pending |
       | app2  | test        | 1      | pending |
       | app3  | test        | 1      | pending |

    And the following engagements exist:
        | id | app_id | coach_id | team_number | start_date | student_names       | features |
        | 1  | 1      | 1        | 1           | 2017-10-01 | fake1, fake2, fake3 | Adding feature boxes |
        | 2  | 1      | 1        | 1           | 2018-04-28 | fake1, fake2, fake3 | Adding feature boxes |
        | 3  | 1      | 1        | 1           | 2018-06-12 | fake1, fake2, fake3 | Adding feature boxes |

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

# Story ID: 176932021
Scenario: A user can see the semester for each iteration on App's detail page
Given I follow "app1"
Then I should see "Semester"
And I should see "FA17"
And I should see "SP18"
And I should see "SU18"

