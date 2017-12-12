Feature: Get iteration feedback from customers who haven't submitted feedback yet
	As a logged in user
	So that I can collect customer feedback of iterations
    I want a customer to be able to fill out a feedback form for the iteration

Background: Logged in
    Given the following users exist:
        | id | name  | github_uid      | email         | user_type |
        | 1  | user1 | esaas_developer | test@user.com | coach     |

    And the following orgs exist:
        | id | name | contact_id |
        | 1  | org1 | 1          |

    Given the following apps exist:
        | id | name  | description | org_id | status  |
        | 1  | app1  | test        | 1      | pending |

    And the following engagements exist:
        | id | app_id | coach_id | team_number | start_date | student_names       |
        | 1  | 1      | 1        | 1           | 2017-10-01 | fake1, fake2, fake3 |

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
        | field                 | value                  |
        | duration              | choose "1 hour"        |
        | demeanor              | choose "Mostly agree"  |
        | engaged               | choose "Mostly agree"  |
        | engaged_text          | They were engaged      |
        | communication         | choose "Mostly agree"  |
        | communication_text    | They communicated well |
        | understanding         | choose "Mostly agree"  |
        | understanding_text    | They understood well   |
        | effectiveness         | choose "Mostly agree"  |
        | effectiveness_text    | They were effective    |
        | satisfied             | choose "Mostly agree"  |
        | satisfied_text        | I am satisfied         |

    And I press "Submit"
    Then I should see "Thank you!"
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    Then the "feedback form" fields should be filled as follows:
        | field                  | value                  |
        | Duration               | 1 hour                 |
        | Demeanor               | Mostly agree           |
        | Engagement             | Mostly agree           |
        | Engagement Comments    | They were engaged      |
        | Communication          | Mostly agree           |
        | Communication Comments | They communicated well |
        | Understanding          | Mostly agree           |
        | Understanding Comments | They understood well   |
        | Effectiveness          | Mostly agree           |
        | Effectiveness Comments | They were effective    |
        | Satisfaction           | Mostly agree           |
        | Satisfaction Comments  | I am satisfied         |
