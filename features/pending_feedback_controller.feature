Feature: get iteration feedback from customers who haven't submitted feedback yet
	As a customer
	So that we can keep track of customer feedback of iterations
    I want to fill out a feedback form for the iteration

Background: Logged in
    Given the following users exist:
        | id | name  | github_uid      | email         |
        | 1  | user1 | esaas_developer | test@user.com |

    And the following orgs exist:
        | id | name | contact_id |
        | 1  | org1 | 1          |

    Given the following apps exist:
        | id | name  | description | org_id | status  |
        | 1  | app1  | test        | 1      | pending |

    And the following engagements exist:
        | id | app_id | contact_id | coaching_org_id | coach_id | team_number | start_date | student_names       |
        | 1  | 1      | 1          | 1               | 1        | 1           | 2017-10-01 | fake1, fake2, fake3 |

    And the following iterations exist:
        | id | engagement_id | end_date   | customer_feedback |
        | 1  | 1             | 2017-10-26 |                   |

    And the following pending feedback exist:
        | id | iteration_id | engagement_id | 
        | 1  | 1            | 1             |     

    And I'm logged in on the orgs page

# Story ID: 152985775
Scenario: A customer can fill out a feedback form and submit it
    Given I am on the feedback form page for engagement id "1" and iteration id "1"
    Then I should see "Please enter your feedback below."
    And I fill in the "Feedback" fields as follows:
        | field                 | value                              |
        | duration              | choose "1 hour"                    |
        | demeanor              | choose "Mostly agree"              | 
        | engaged               | choose "Mostly agree"              | 
        | engaged_text          | They were engaged                  | 
        | communication         | choose "Mostly agree"              | 
        | communication_text    | They communicated well             | 
        | understanding         | choose "Mostly agree"              | 
        | understanding_text    | They understood well               | 
        | effectiveness         | choose "Mostly agree"              | 
        | effectiveness_text    | They were effective                | 
        | satisfied             | choose "Mostly agree"              |
        | satisfied_text        | I am satisfied                     |

    And I press "Submit"
    Then I should see "Thank you!"
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    Then the field "duration" should be filled with "1 hour"
    And the field "demeanor" should be filled with "Mostly agree"
    And the field "engaged" should be filled with "Mostly agree"
    And the field "engaged_text" should be filled with "They were engaged"
    And the field "communication" should be filled with "Mostly agree"
    And the field "communication_text" should be filled with "They communicated well"
    And the field "understanding" should be filled with "Mostly agree"
    And the field "understanding_text" should be filled with "They understood well"
    And the field "effectiveness" should be filled with "Mostly agree"
    And the field "effectiveness_text" should be filled with "They were effective"
    And the field "satisfied" should be filled with "Mostly agree"
    And the field "satisfied_text" should be filled with "I am satisfied"
