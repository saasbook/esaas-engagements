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
        | id | app_id | coach_id | team_number | start_date | student_names       |
        | 1  | 1      | 1        | 1           | 2017-10-01 | fake1, fake2, fake3 |

    And the following iterations exist:
        | id | engagement_id | end_date   | customer_feedback |
        | 1  | 1             | 2017-10-26 |                   |
        | 2  | 1             | 2017-10-31 | {"duration":"15 min", "demeanor":"Strongly agree", "engaged":"Strongly agree", "engaged_text":"i", "communication":"Strongly agree", "communication_text":"i", "understanding":"Strongly agree", "understanding_text":"i", "effectiveness":"Strongly agree", "effectiveness_text":"i", "satisfied":"Strongly agree", "satisfied_text":"I am satisfied"} |
    And I'm logged in on the orgs page

# Story ID: 152298649
Scenario: When I'm on the edit page, I see the edit form
    Given I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then I should see "End date:"
    And I should see "Duration:"
    And I should see "Demeanor:"
    And I should see "Engaged:"
    And I should see "Engagement comments:"
    And I should see "Communication:"
    And I should see "Communication comments:"
    And I should see "Understanding:"
    And I should see "Understanding comments:"
    And I should see "Effectiveness:"
    And I should see "Effectiveness comments:"
    And I should see "Satisfied:"
    And I should see "Satisfied comments:"

# Story ID: 152298649
Scenario: If feedback already submiited by form, I can edit the feedback and see the changes
    Given I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then the field "duration" should be filled with "15 min"
    And the field "satisfied_text" should be filled with "I am satisfied"
    When I fill in the "Feedback" fields as follows:
        | field                              | value              |
        | customer_feedback[duration]        | select "30 min"    |
        | customer_feedback[satisfied_text]  | I'm super happy!!! |
    And I press "Save Changes"
    Then I should see "Iteration was successfully updated."
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then the field "duration" should be filled with "30 min"
    And the field "satisfied_text" should be filled with "I'm super happy!!!"

# Story ID: 152298649
Scenario: I can leave a comment field blank and it may still be saved
    Given I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    When I fill in the "Feedback" fields as follows:
        | field                             | value              |
        | customer_feedback[duration]       | select "45 min"    |
        | customer_feedback[satisfied_text] |                    |
    And I press "Save Changes"
    Then I should see "Iteration was successfully updated."
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then the field "duration" should be filled with "45 min"
    And the field "satisfied_text" should be filled with ""

# Story ID: 152689630
Scenario: If feedback hasn't been submitted by form yet and is blank, a user can manually add in feedback
Given I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    And I fill in the "Feedback" fields as follows:
        | field                                  | value                              |
        | customer_feedback[duration]            | select "1 hour"                    |
        | customer_feedback[demeanor]            | select "Mostly agree"              |
        | customer_feedback[engaged]             | select "Strongly agree"            |
        | customer_feedback[engaged_text]        | They were engaged                  |
        | customer_feedback[communication]       | select "Neither agree nor disagree"|
        | customer_feedback[communication_text]  | They communicated well             |
        | customer_feedback[understanding]       | select "Mostly disagree"           |
        | customer_feedback[understanding_text]  | They understood well               |
        | customer_feedback[effectiveness]       | select "Strongly disagree"         |
        | customer_feedback[effectiveness_text]  | They were effective                |
        | customer_feedback[satisfied]           | select "Mostly agree"              |
        | customer_feedback[satisfied_text]      | I am satisfied                     |
    And I press "Save Changes"
    Then I should see "Iteration was successfully updated."
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    Then the "feedback form" fields should be filled as follows:
        | field               | value                      |
        | duration            | 1 hour                     |
        | demeanor            | Mostly agree               |
        | engaged             | Strongly agree             |
        | engaged_text        | They were engaged          |
        | communication       | Neither agree nor disagree |
        | communication_text  | They communicated well     |
        | understanding       | Mostly disagree            |
        | understanding_text  | They understood well       |
        | effectiveness       | Strongly disagree          |
        | effectiveness_text  | They were effective        |
        | satisfied           | Mostly agree               |
        | satisfied_text      | I am satisfied             |
