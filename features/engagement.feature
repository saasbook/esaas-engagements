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
