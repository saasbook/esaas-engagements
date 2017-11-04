Feature: an org can be destroyed
    
    As an admin user
    So that we can delete orgs that we no longer want to keep track of
    I want to destroy an org

Background: Logged in
    And the following users exist:
        | name  | github_uid      | email         |
        | user1 | esaas_developer | test@user.com |

    And the following orgs exist:
        | name | contact_id | id |
        | org1 | 1          | 1  |

    And I'm logged in on the orgs page

Scenario: I can delete an org
    When I delete the org with id "1"
    Then I should see "Org was successfully destroyed."
