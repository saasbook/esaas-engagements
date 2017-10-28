Feature: displaying summarizing stats for the engagment based on customer feedback
    As a staff or an organization who uses the app
    I want to see how the team performed over the iterations
    So that I can grade the team / make decision on which team to hire

Background: Seeding data / logging into the app
    Given the following apps exist:
        | id | name  | description | org_id | status  |
        | 1  | app1  | test        | 1      | pending |

    And the following orgs exist:
        | id | name | contact_id |
        | 1  | org1 | 1          |

    And the following users exist:
        | id | name    | github_uid      | email            |
        | 1  | coach   | esaas_developer | coach@user.com   |
        | 2  | contact |                 | contact@user.com |

    And the following engagements exist:
        | id | app_id | coaching_org_id | coach_id | contact_id | team_number | start_date | student_names |
        | 1  | 1      | 1               | 1        | 2          | 1           | 2017-03-25 | s1, s2, s3    |

    And the following iterations exist:
        | id | engagement_id | end_date   |
        | 1  | 1             | 2017-04-14 |

    And Iteration "1" has the following customer feedback:
        | duration | demeanor | engaged | engaged_text | communication | communication_text | understanding | understanding_text | effectiveness | effectiveness_text | satisfied | satisfied_text |
        | 45 min | Strongly agree | Mostly agree | Very Engaged | Strongly agree | good | Strongly agree | nice | Strongly agree | great | Strongly agree | love |

    And I'm logged in on the orgs page

Scenario: Engagement summary is displayed
    Given I am on Engagement page for an engagement with an app "app1" and start date "2017-03-25"
    Then I should see "Demeanor: 5.0 / 5.0"
    And I should see "Engagement: 4.0 / 5.0"
    And I should see "Communication: 5.0 / 5.0"
    And I should see "Understanding: 5.0 / 5.0"
    And I should see "Effectiveness: 5.0 / 5.0"
    And I should see "Satisfaction: 5.0 / 5.0"

Scenario: Engagement summary averages the scores from all iterations
    Given I add the following iteration:
        | id | engagement_id | end_date   |
        | 2  | 1             | 2017-04-28 |

    And Iteration "2" has the following customer feedback:
        | duration | demeanor | engaged | engaged_text | communication | communication_text | understanding | understanding_text | effectiveness | effectiveness_text | satisfied | satisfied_text |
        | 30 min | Mostly agree | Mostly agree | Very Engaged | Mostly disagree | good | Strongly agree | nice | Mostly agree | great | Neither agree nor disagree | love |

    And I am on Engagement page for an engagement with an app "app1" and start date "2017-03-25"
    Then I should see "Demeanor: 4.5 / 5.0"
    And I should see "Engagement: 4.0 / 5.0"
    And I should see "Communication: 3.5 / 5.0"
    And I should see "Understanding: 5.0 / 5.0"
    And I should see "Effectiveness: 4.5 / 5.0"
    And I should see "Satisfaction: 4.0 / 5.0"