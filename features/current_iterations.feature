Feature: See all customers who haven't given feedback
	As a logged in user
	So that I can easily see which customers to remind to fill out a feedback form
    I want to see all iterations that don't have feedback yet

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

    And I'm logged in on the orgs page

# Story ID: 152985775
Scenario: A user can go on the current iterations page and see list of iterations that don't have feedback
    Given I am on the current iteration page
    Then I should see "Get customer feedback"
    And I should see "End date"
    And I should see "App Customer"
    And I should see "Email"
    And I should see "Email sent?"
    And I should see "test@user.com"