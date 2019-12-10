@javascript
Feature: Accessibility for each page

  Background: seed data and logged as coach

    Given the following apps exist:
      | id  | name  | description | org_id |
      | 1   | app1  | test1       | 1      |

    And the following orgs exist:
      | id | name | contact_id |
      | 1  | org1 | 1          |

    And the following users exist:
      | id | name  | github_uid      | email          | user_type     | developing_engagement_id |
      | 1  | user1 | esaas_developer | test@user.com  | coach         |       1                  |

    And the following App Edit Requests exist:
      | id | description  |
      | 1  |    app1      |

    And the following engagements exist:
      | id | app_id | coach_id | team_number | start_date |
      | 1  | 1      | 1        | 1           | 2017-03-25 |

    And the following iterations exist:
      | id | engagement_id | end_date   |
      | 1  | 1             | 2017-04-14 |

    And the following App Edit Requests exist:
      | id | description  | features    | feedback | status      | approval_time | app_id | requester_id    | approver_id | created_at                 | updated_at |
      | 1  | app1         | test1       |          | submitted   |               | 1      | 1               | 1           | 2019-11-20 7:44:50 -0800   |            |

    And I am logged in

  @javascript
  Scenario: App page
    When I follow "Apps"
    And the page should be accessible
    When I follow "New App"
    Then the page should be accessible
    Given I follow "Back"
    When I follow "Edit"
    Then the page should be accessible
    And I press "Update App"
    When I follow "app1"
    #    Then the page should be accessible
    #    When I follow "New Engagement"
    #    Then the page should be accessible
    #    And I follow "Back"
    #    And I follow "Request Feedback"
    #    Then the page should be accessible
    #    When I press "Create Iteration"
    #    Then the page should be accessible
    #    When I press "Edit"
    #    Then the page should be accessible

  @javascript
  Scenario: Project page
    When I follow "My Projects"
    Then the page should be accessible
    When I follow "Update Request"
    # Then the page should be accessible

  @javascript
  Scenario: App Edit Requests page
    When I follow "App Edit Requests"
    Then the page should be accessible
    When I follow "View Request"
    # Then the page should be accessible

  @javascript
  Scenario: Orgs page
    When I follow "Orgs"
    Then the page should be accessible
    When I follow "org1"
    # Then the page should be accessible
    # When I follow "Edit Org"
    # Then the page should be accessible

  @javascript
  Scenario: Users page
    When I follow "Users"
    Then the page should be accessible
    When I follow "user1"
    # Then the page should be accessible
    # When I follow "Edit User"
    # Then the page should be accessible

  @javascript
  Scenario: Create page
    When I follow "Create"
    Then the page should be accessible

  @javascript
  Scenario: Current Iteration page
    When I follow "Current iteration"
    Then the page should be accessible

  @javascript
  Scenario: Login page
    When I follow "Logout"
    Then the page should be accessible
