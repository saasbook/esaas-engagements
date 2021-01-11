Feature: after a coach logs in with their github id they have access to my projects tab
  As a logged in coach of ESaaS Engagements
  I should see a tab labeled “My Projects” on any page of ESaaS Engagements
  So that I can manage my projects

  Background: seed data and log in
    Given the following users exist:
      | id | name  | github_uid      | email          | user_type     |
      | 1  | user1 | esaas_developer | test@user.com  | coach         |

    And the following orgs exist:
      | name | contact_id |
      | org1 | 1          |

    And there is 1 app with sequence format:
      | name   | description     | org_id | status  |
      | app    | app-description | 1      | pending |

Scenario: A coach that is not logged in cannot see 'My Projects' tab
  Given I am not logged in
  Then I should not see "My Projects"

Scenario: A coach that is logged in can see 'My Projects' tab and have access to the same functionality as a client
  Given I am logged in
  Then I should see "My Projects"
  When I follow "My Projects"
  Then I should be on the my projects page
  And I should see "app-1"
  And I should see "app-description-1"
  And I should see "Request Change"
  When I follow "Request Change"
  Then I should be on the new edit request page for app-1
