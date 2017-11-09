Feature: a user can download the data for an engagement in the form of a csv file
    
    AS a developer,
    SO THAT the staff and other developers can access the engagement information without having to look at the website,
    I WANT the app to dump the engagement information as a CSV file
    
Background: Logged in and on the orgs page
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
        | 1  | 1      | 1          | 1               | 1        | 1           | 2017-10-01 | fake1               |

    And the following iterations exist:
        | id | engagement_id | end_date   | customer_feedback |
        | 1  | 1             | 2017-10-26 |                   |
        | 2  | 1             | 2017-10-31 | {"duration":"15 min", "demeanor":"Strongly agree", "engaged":"Strongly agree", "engaged_text":"i", "communication":"Strongly agree", "communication_text":"i", "understanding":"Strongly agree", "understanding_text":"i", "effectiveness":"Strongly agree", "effectiveness_text":"i", "satisfied":"Strongly agree", "satisfied_text":"I am satisfied"} | 
    And I am on the engagement iterations page for "1"

# Story ID: 152689294
Scenario: I can access the download button
    Then I should see "Download CSV"

# Story ID: 152689294
Scenario: I can download the engagement data
    Given I am on the engagement iterations page for "1"
    And I press "Download CSV"
    Then I should have downloaded "1, 1, 1, 1, 1, 1, 2017-10-01, fake1, 15 min", "Strongly agree", "Strongly agree", "i", "Strongly agree", "i", "Strongly agree", "i", "Strongly agree", "i", "Strongly agree", "I am satisfied""