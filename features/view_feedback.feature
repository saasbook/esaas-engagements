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
        | id | engagement_id | end_date   | 
        | 1  | 1             | 2017-10-26 | 

Scenario: after I submit the feedback form I should see the feedback on the engagement iterations page and the edit iteration page
    Given I am on the feedback form page for engagement id "1" and iteration id "1"
    And I fill in the "Feedback" form as follows:
        | field                 | value                     |
        | duration              | 1 hour                    |
        | demeanor              | Mostly agree              | 
        | engaged               | Mostly agree              | 
        | engaged_text          | They were engaged         | 
        | communication         | Mostly agree              | 
        | communication_text    | They communicated well    | 
        | understanding         | Mostly agree              | 
        | understanding_text    | They understood well      | 
        | effectiveness         | Mostly agree              | 
        | effectiveness_text    | They were effective       | 
        | satisfied             | Mostly agree              |
        | satisfied_text        | I am satisfied            |

    And I press "Submit"

    When I am on the engagement iterations page for engagement id "1"
    Then I should see "effectiveness: Mostly agree"
    And I should see "duration: 1 hour"
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    Then I should see "effectiveness: Mostly agree"
    And I should see "duration: 1 hour"

Scenario: if I edit the customer feedback, I should see the changes on the engagement iterations page and the edit iteration page
    Given I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    And I fill in the category "duration" with value "50 minutes"
    And I press "Submit"
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    Then I should see "duration: 50 minutes"
    When I am on the engagement iterations page for engagement id "1"
    Then I should see "duration: 50 minutes"


