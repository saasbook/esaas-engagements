Feature: having a better view for iteration feedback
	As a logged in user
	So that I can easily read customer feedback on engagement iterations
    I want to see iteration feedback in plain English

Background: Logged in
    Given the following users exist:
        | id | name  | github_uid      | email          | user_type     |
        | 1  | user1 | esaas_developer | test@user.com  | coach         |
        | 2  | user2 |                 | test1@user.com | student       |
        | 3  | user3 |                 | test2@user.com | coach         |

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
    Then I should see "End Date"
    And I should see "Duration"
    And I should see "Demeanor"
    And I should see "Engagement"
    And I should see "Engagement Comments"
    And I should see "Communication"
    And I should see "Communication Comments"
    And I should see "Understanding"
    And I should see "Understanding Comments"
    And I should see "Effectiveness"
    And I should see "Effectiveness Comments"
    And I should see "Satisfaction"
    And I should see "Satisfaction Comments"

# Story ID: 152298649
Scenario: If feedback already submiited by form, I can edit the feedback and see the changes
    Given I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then the field "Duration" should be filled with "15 min"
    And the field "Satisfaction Comments" should be filled with "I am satisfied"
    When I fill in the "Feedback" fields as follows:
        | field                                         | value              |
        | iteration[customer_feedback][duration]        | select "30 min"    |
        | iteration[customer_feedback][satisfied_text]  | I'm super happy!!! |
    And I press "Update Iteration"
    Then I should see "Iteration was successfully updated."
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then the field "Duration" should be filled with "30 min"
    And the field "Satisfaction Comments" should be filled with "I'm super happy!!!"

# Story ID: 152298649
Scenario: I can leave a comment field blank and it may still be saved
    Given I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    When I fill in the "Feedback" fields as follows:
        | field                                        | value              |
        | iteration[customer_feedback][duration]       | select "45 min"    |
        | iteration[customer_feedback][satisfied_text] |                    |
    And I press "Update Iteration"
    Then I should see "Iteration was successfully updated."
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "2"
    Then the field "Duration" should be filled with "45 min"
    And the field "Satisfaction Comments" should be filled with ""

# Story ID: 152689630
Scenario: If feedback hasn't been submitted by form yet and is blank, a user can manually add in feedback
Given I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    And I fill in the "Feedback" fields as follows:
        | field                                  | value                              |
        | iteration[customer_feedback][duration]            | select "1 hour"                    |
        | iteration[customer_feedback][demeanor]            | select "Mostly agree"              |
        | iteration[customer_feedback][engaged]             | select "Strongly agree"            |
        | iteration[customer_feedback][engaged_text]        | They were engaged                  |
        | iteration[customer_feedback][communication]       | select "Neither agree nor disagree"|
        | iteration[customer_feedback][communication_text]  | They communicated well             |
        | iteration[customer_feedback][understanding]       | select "Mostly disagree"           |
        | iteration[customer_feedback][understanding_text]  | They understood well               |
        | iteration[customer_feedback][effectiveness]       | select "Strongly disagree"         |
        | iteration[customer_feedback][effectiveness_text]  | They were effective                |
        | iteration[customer_feedback][satisfied]           | select "Mostly agree"              |
        | iteration[customer_feedback][satisfied_text]      | I am satisfied                     |
    And I press "Update Iteration"
    Then I should see "Iteration was successfully updated."
    When I am on the edit engagement iteration page for engagement id "1" and iteration id "1"
    Then the "feedback form" fields should be filled as follows:
        | field                  | value                      |
        | Duration               | 1 hour                     |
        | Demeanor               | Mostly agree               |
        | Engagement             | Strongly agree             |
        | Engagement Comments    | They were engaged          |
        | Communication          | Neither agree nor disagree |
        | Communication Comments | They communicated well     |
        | Understanding          | Mostly disagree            |
        | Understanding Comments | They understood well       |
        | Effectiveness          | Strongly disagree          |
        | Effectiveness Comments | They were effective        |
        | Satisfaction           | Mostly agree               |
        | Satisfaction Comments  | I am satisfied             |
