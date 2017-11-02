Feature: having a better view for iteration feedback
	As a logged in user
	So that I can easily read customer feedback on engagement iterations
    I want to see iteration feedback in plain English

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
        | 2  | 1             | 2017-10-31 | {"duration":"15 min", "demeanor":"Strongly agree", "engaged":"Strongly agree", "engaged_text":"i", "communication":"Strongly agree", "communication_text":"i", "understanding":"Strongly agree", "understanding_text":"i", "effectiveness":"Strongly agree", "effectiveness_text":"i", "satisfied":"Strongly agree", "satisfied_text":"I am satisfied"} | 
    And I'm logged in on the orgs page

Scenario: after I submit the feedback form I should see the feedback on the engagement iterations page and the edit iteration page
    Given I am on the current iteration page
    And I follow "Get customer feedback"
    When I am on the feedback form page for engagement id "1" and iteration id "1"
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

    #And I press "Submit"

    #When I am on the engagement iterations page for engagement id "1"
    #Then I should see "effectiveness: Mostly agree"
    #And I should see "duration: 1 hour"
    #When I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    #Then I should see "effectiveness: Mostly agree"
    #And I should see "duration: 1 hour"

Scenario: if I edit the customer feedback, I should see the changes on the engagement iterations page and the edit iteration page
    Given I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then the field "duration" should be filled with "15 min"
    And the field "satisfied_text" should be filled with "I am satisfied"
    And I fill in the "Feedback" fields as follows:
        | field                             | value              |
        | customer_feedback[duration]       | 30 min             |
        | customer_feedback[satisfied_text]  | I'm super happy!!! |
    And I press "Save Changes"
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then the field "duration" should be filled with "30 min"
    And the field "satisfied_text" should be filled with "I'm super happy!!!"
    When I am on the engagement iterations page for engagement id "1"
    Then I should see "duration: 30 minutes"


