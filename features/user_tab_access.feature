# Feature: Test different user access to top bar tabs
#    As a certain user who visit the Esaas website
#    I have different access rights
#    So that I can see all or only some of the tabs


# Background: There are three type of user in ddatabase
#    Given the following users exist:
#       | id | name  | github_uid           | email                             | type_user    |
#       | 1  | user1 | esaas_developer      | esaas_developer@saasbook.info"    | Coach        |
#       | 2  | user2 | esaas_student_github | test1@user.com                    | Student      |
#       | 3  | user3 | esaas_client_github  | test2@user.com                    | Client       |

# @Guest
# Scenario: Visit website as a guest I can see (Happy)
#    Given I am not logged in
#    Then I should see "Apps"
#    And I should see "Orgs"
#    And I should see "Users"
#    And I should see "Create"
#    And I should see "Help"
#    And I should see "Login"

# Scenario: Visit website as a guest I cannot see (Sad)
#    Given I am not logged in
#    And I should not see "My Projects"
#    And I should not see "App Edit Requests"
#    And I should not see "Current Iteration"
#    And I should not see "Project Matchings"
#    And I should not see "Logout"

# Scenario: Visit website as a guest I should be redirect to login only 
#    Given I am not logged in
#    When I follow "Apps"
#    Then I should see "Login to ESaaS Engagements"
#    And I should see "Log in with GitHub"
#    When I follow "Orgs"
#    Then I should see "Login to ESaaS Engagements"
#    When I follow "Users"
#    Then I should see "Login to ESaaS Engagements"
#    When I follow "Create"
#    Then I should see "Login to ESaaS Engagements"
#    # When I follow "Help"
#    # TODO: test external link


# @Coach
# Scenario: Login with coach github account
#    Given I will be logged in as "coach" type
#    Given I am logged in
#    Then I should see "Apps"
#    And I should see "My Projects"
#    And I should see "App Edit Requests"
#    And I should see "Orgs"
#    And I should see "Users"
#    And I should see "Create"
#    And I should see "Help"
#    And I should see "Current Iteration"
#    And I should see "Project Matchings"
#    And I should see "Logout @esaas_developer"


# @Student
# Scenario: Login with random(not in matching) student github account and I can see (Happy)
#    Given I will be logged in as "student" type
#    Given I am logged in
#    Then I should see "Apps"
#    And I should see "Orgs"
#    And I should see "Users"
#    And I should see "Create"
#    And I should see "Help"
#    And I should see "My Projects"
#    And I should see "Logout @esaas_student_github"

# Scenario: Login with random student github account and I cannot see (Sad)
#    Given I will be logged in as "student" type
#    Given I am logged in
#    Then I should not see "Current Iteration"
#    And I should not see "Project Matchings"
#    And I should not see "App Edit Requests"


# Scenario: Visit website as a random student I should be redirect to correct page 
#    Given I will be logged in as "student" type
#    Given I am logged in
#    # When I follow "Apps"
#    # Then I should not see "Login to ESaaS Engagements"
#    # When I follow "Orgs"
#    # Then I should not see "Login to ESaaS Engagements"
#    # When I follow "Users"
#    # Then I should not see "Login to ESaaS Engagements"
#    # When I follow "Create"
#    # Then I should not see "Login to ESaaS Engagements"

# # TODO:
# # @ProjectMatchingStudent
