Feature: after a client logs in with their github id they have access to my projects tab
  As a logged in client of ESaaS Engagements
  I should see a tab labeled “My Projects” on any page of ESaaS Engagements
  So that I can manage my projects

  Background: seed data and log in
    Given the following users exist:
      | id | name  | github_uid      | email          | user_type     |
      | 1  | user1 | esaas_developer | test@user.com  | client        |
      | 2  | user2 |                 | test1@user.com | student       |
      | 3  | user3 |                 | test2@user.com | client        |
      | 4  | user4 |                 | test4@user.com | client        |

    And the following orgs exist:
      | name | contact_id |
      | org1 | 1          |
      | org2 | 1          |
      | org3 | 1          |

    And there are 200 apps with sequence format:
      | name   | description     | org_id | status  |
      | app    | app-description | 1      | pending |

# Story ID: 169387986
Scenario: A client that is not logged in cannot see 'My Projects' tab
  Given I am not logged in
  Then I should not see "My Projects"

# Story ID: 169387986
Scenario: A client that is logged in can see 'My Projects' tab
  Given I am logged in
  Then I should see "My Projects"

# Story ID: 169387986
Scenario: A logged in user can see list of their projects in 'My Projects' tab
  Given I am logged in
  When I follow "My Projects"
  Then I should see 10 apps starting with app 1 with sequence format:
    | name  | description     |
    | app   | app-description |

# Story ID: 169387986
Scenario: A client with many apps should see the first 10 apps by default
  Given I am logged in
  When I follow "My Projects"
  And I follow "10"
  Then I should see 10 apps starting with app 1 with sequence format:
    | name  | description     |
    | app   | app-description |
  When I follow "2"
  Then I should see 10 apps starting with app 11 with sequence format:
    | name  | description     |
    | app   | app-description |
  When I follow "3"
  Then I should see 10 apps starting with app 21 with sequence format:
    | name  | description     |
    | app   | app-description |
  When I follow "4"
  Then I should see 10 apps starting with app 31 with sequence format:
    | name  | description     |
    | app   | app-description |
  When I follow "3"
  Then I should see 10 apps starting with app 21 with sequence format:
    | name  | description     |
    | app   | app-description |
  When I follow "50"
  Then I should see 50 apps starting with app 1 with sequence format:
    | name  | description     |
    | app   | app-description |
  When I follow "100"
  Then I should see 100 apps starting with app 1 with sequence format:
    | name  | description     |
    | app   | app-description |
  When I follow "2"
  Then I should see 100 apps starting with app 101 with sequence format:
    | name  | description     |
    | app   | app-description |
