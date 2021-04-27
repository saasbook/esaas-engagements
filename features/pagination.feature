Feature: a user can choose the number of apps, orgs and users show in one page

    As an admin user
    In order to view numerous apps, orgs and users easier
    I want to choose number of apps, orgs and users in one page according to my favor

Background: Logged in
    Given the following apps exist:
        | id	|name  | description  | org_id | status          |
        | 1	    |app_a  | test        | 1      | pending         |
        | 2	    |app_b  | test        | 2      | pending         |
        | 3	    |app_c  | test        | 3      | pending         |
        | 4     |app_d  | test        | 4      | pending         |
        | 5	    |app_e  | test        | 5      | pending         |
        | 6	    |app_f  | test        | 6      | pending         |
        | 7	    |app_g  | test        | 7      | pending         |
        | 8	    |app_h  | test        | 8      | pending         |
        | 9	    |app_i  | test        | 9      | pending         |
        | 10	|app_j  | test        | 10     | pending         |
        | 11	|app_k  | test        | 11     | pending         |
        | 12	|app_l  | test        | 12     | vetting_pending |

    And the following orgs exist:
        | id	|name  |contact_id |
        | 1	    |org_a | 1         |
        | 2	    |org_b | 2         |
        | 3	    |org_c | 1         |
        | 4	    |org_d | 1         |
        | 5	    |org_e | 1         |
        | 6  	|org_f | 1         |
        | 7	    |org_g | 1         |
        | 8	    |org_h | 1         |
        | 9	    |org_i | 1         |
        | 10	|org_j | 1         |
        | 11	|org_k | 1         |
        | 12	|org_l | 1         |

    And the following users exist:
        | id | name   | github_uid	    | email			    | user_type	|
        | 1  | user_a |	esaas_developer	| test@user.com		| coach		|
        | 2  | user_b |			        | test1@user.com	| coach		|
        | 3  | user_c | 		        | test2@user.com	| coach		|
        | 4  | user_d |			        | test3@user.com	| student	|
        | 5  | user_e |			        | test4@user.com	| student	|
        | 6  | user_f |			        | test5@user.com	| coach		|
        | 7  | user_g |			        | test6@user.com	| student	|
        | 8  | user_h |			        | test7@user.com	| coach		|
        | 9  | user_i |			        | test8@user.com	| coach 	|
        | 10 | user_j |			        | test9@user.com	| student	|
        | 11 | user_k |			        | test10@user.com	| coach		|
        | 12 | user_l |			        | test11@user.com	| student	|

Scenario: There are some click buttons on apps page that I can control the pagination
    Given I am on the apps page
    And I follow "Log in with GitHub"
    Then I should see "10"
    And I should see "50"
    And I should see "100"
    And I should see "All"
    And I should see "First"
    And I should see "Last"

Scenario: I can see all apps with selection all
    Given I am on the apps page
    And I follow "Log in with GitHub"
    When I follow "All"
    Then I should see "app_a"
    And I should see "app_b"
    And I should see "app_k"
    And I should see "app_l"

Scenario: I can press number buttons to do pagination
    Given I am on the apps page
    And I follow "Log in with GitHub"
    When I follow "10"
    Then I should see "app_a"
    And I should see "app_b"
    And I should see "app_j"
    And I should not see "app_k"
    And I should not see "app_l"

Scenario: I can use "next" and "previous" buttons to see previous or next apps
    Given I am on the apps page
    And I follow "Log in with GitHub"
    When I follow "10"
    Then I should see "app_a"
    And I should see "app_b"
    And I should see "app_c"
    And I should see "app_d"
    And I should see "app_e"
    And I should see "app_f"
    And I should see "app_g"
    And I should see "app_h"
    And I should see "app_i"
    And I should see "app_j"
    And I should not see "app_k"
    And I should not see "app_l"
    When I follow "2"
    Then I should not see "app_a"
    And I should not see "app_b"
    And I should not see "app_c"
    And I should not see "app_d"
    And I should not see "app_e"
    And I should not see "app_f"
    And I should not see "app_g"
    And I should not see "app_h"
    And I should not see "app_i"
    And I should not see "app_j"
    And I should not see "app_j"
    And I should see "app_k"
    And I should see "app_l"
    When I follow "1"
    Then I should see "app_a"
    And I should see "app_b"
    And I should see "app_c"
    And I should see "app_d"
    And I should see "app_e"
    And I should see "app_f"
    And I should see "app_g"
    And I should see "app_h"
    And I should see "app_i"
    And I should see "app_j"
    And I should not see "app_k"
    And I should not see "app_l"

Scenario: I can click "First" or "Last" to see the first page or last page of apps
    Given I am on the apps page
    And I follow "Log in with GitHub"
    When I follow "10"
    Then I should see "app_b"
    And I should not see "app_k"
    And I should not see "app_l"
    When I follow "Last"
    Then I should not see "app_j"
    And I should see "app_k"
    And I should see "app_l"
    When I follow "First"
    Then I should see "app_b"
    And I should not see "app_k"
    And I should not see "app_l"

# These scenarios now obsolete since front end redesign prevents it from happening
#Scenario: I cannot press previous in the very front page
#    Given I am on the apps page
#    When I follow "All"
#    And I follow "Previous"
#    Then I should see "app_b"
#    And I should see "You are already on the FIRST page."

#Scenario: I cannot press previous in the very front page
#    Given I am on the apps page
#    When I follow "All"
#    And I follow "Next"
#    Then I should see "app_k"
#    When I follow "Next"
#    Then I should see "app_k"
#    And I should see "You are already on the LAST page."

Scenario: There are some click buttons on orgs page that I can control the pagination
    Given I am on the orgs page
    And I follow "Log in with GitHub"
    Then I should see "10"
    And I should see "50"
    And I should see "100"
    And I should see "All"
    And I should see "First"
    And I should see "Previous"
    And I should see "Next"
    And I should see "Last"

Scenario: I can see all orgs with selection all
    Given I am on the orgs page
    And I follow "Log in with GitHub"
    When I follow "All"
    Then I should see "org_a"
    And I should see "org_b"
    And I should see "org_k"
    And I should see "org_l"

Scenario: I can press number buttons to do pagination
    Given I am on the orgs page
    And I follow "Log in with GitHub"    
    When I follow "10"
    Then I should see "org_a"
    And I should see "org_b"
    And I should see "org_j"
    And I should not see "org_k"
    And I should not see "org_l"

Scenario: I can use "next" and "previous" buttons to see previous or next orgs
    Given I am on the orgs page
    And I follow "Log in with GitHub"    
    When I follow "10"
    Then I should see "org_a"
    And I should see "org_b"
    And I should see "org_c"
    And I should see "org_d"
    And I should see "org_e"
    And I should see "org_f"
    And I should see "org_g"
    And I should see "org_h"
    And I should see "org_i"
    And I should see "org_j"
    And I should not see "org_k"
    And I should not see "org_l"
    When I follow "Next"
    Then I should not see "org_a"
    And I should not see "org_b"
    And I should not see "org_c"
    And I should not see "org_d"
    And I should not see "org_e"
    And I should not see "org_f"
    And I should not see "org_g"
    And I should not see "org_h"
    And I should not see "org_i"
    And I should not see "org_j"
    And I should not see "org_j"
    And I should see "org_k"
    And I should see "org_l"
    When I follow "Previous"
    Then I should see "org_a"
    And I should see "org_b"
    And I should see "org_c"
    And I should see "org_d"
    And I should see "org_e"
    And I should see "org_f"
    And I should see "org_g"
    And I should see "org_h"
    And I should see "org_i"
    And I should see "org_j"
    And I should not see "org_k"
    And I should not see "org_l"

Scenario: I can click "First" or "Last" to see the first page or last page of orgs
    Given I am on the orgs page
    And I follow "Log in with GitHub"    
    When I follow "10"
    Then I should see "org_b"
    And I should not see "org_k"
    And I should not see "org_l"
    When I follow "Last"
    Then I should not see "org_j"
    And I should see "org_k"
    And I should see "org_l"
    When I follow "First"
    Then I should see "org_b"
    And I should not see "org_k"
    And I should not see "org_l"

Scenario: I cannot press previous in the very front page
    Given I am on the orgs page
    And I follow "Log in with GitHub"    
    When I follow "All"
    And I follow "Previous"
    Then I should see "org_b"
    And I should see "You are already on the FIRST page."

Scenario: I cannot press previous in the very front page
    Given I am on the orgs page
    And I follow "Log in with GitHub"    
    When I follow "All"
    And I follow "Next"
    Then I should see "org_k"
    When I follow "Next"
    Then I should see "org_k"
    And I should see "You are already on the LAST page."

Scenario: There are some click buttons on users page that I can control the pagination
    Given I am on the users page
    And I follow "Log in with GitHub"    
    Then I should see "10"
    And I should see "50"
    And I should see "100"
    And I should see "All"
    And I should see "First"
    And I should see "Previous"
    And I should see "Next"
    And I should see "Last"

Scenario: I can see all users with selection all
    Given I am on the users page
    And I follow "Log in with GitHub"    
    When I follow "All"
    Then I should see "user_a"
    And I should see "user_b"
    And I should see "user_k"
    And I should see "user_l"

Scenario: I can press number buttons to do pagination
    Given I am on the users page
    And I follow "Log in with GitHub"    
    When I follow "10"
    Then I should see "user_a"
    And I should see "user_b"
    And I should see "user_j"
    And I should not see "user_k"
    And I should not see "user_l"

Scenario: I can use "next" and "previous" buttons to see previous or next users
    Given I am on the users page
    And I follow "Log in with GitHub"    
    When I follow "10"
    Then I should see "user_a"
    And I should see "user_b"
    And I should see "user_c"
    And I should see "user_d"
    And I should see "user_e"
    And I should see "user_f"
    And I should see "user_g"
    And I should see "user_h"
    And I should see "user_i"
    And I should see "user_j"
    And I should not see "user_k"
    And I should not see "user_l"
    When I follow "Next"
    Then I should not see "user_a"
    And I should not see "user_b"
    And I should not see "user_c"
    And I should not see "user_d"
    And I should not see "user_e"
    And I should not see "user_f"
    And I should not see "user_g"
    And I should not see "user_h"
    And I should not see "user_i"
    And I should not see "user_j"
    And I should not see "user_j"
    And I should see "user_k"
    And I should see "user_l"
    When I follow "Previous"
    Then I should see "user_a"
    And I should see "user_b"
    And I should see "user_c"
    And I should see "user_d"
    And I should see "user_e"
    And I should see "user_f"
    And I should see "user_g"
    And I should see "user_h"
    And I should see "user_i"
    And I should see "user_j"
    And I should not see "user_k"
    And I should not see "user_l"

Scenario: I can click "First" or "Last" to see the first page or last page of users
    Given I am on the users page
    And I follow "Log in with GitHub"    
    When I follow "10"
    Then I should see "user_b"
    And I should not see "user_k"
    And I should not see "user_l"
    When I follow "Last"
    Then I should not see "user_j"
    And I should see "user_k"
    And I should see "user_l"
    When I follow "First"
    Then I should see "user_b"
    And I should not see "user_k"
    And I should not see "user_l"

Scenario: I cannot press previous in the very front page
    Given I am on the users page
    And I follow "Log in with GitHub"    
    When I follow "All"
    And I follow "Previous"
    Then I should see "user_b"
    And I should see "You are already on the FIRST page."

Scenario: I cannot press previous in the very front page
    Given I am on the users page
    And I follow "Log in with GitHub"    
    When I follow "All"
    And I follow "Next"
    Then I should see "user_k"
    When I follow "Next"
    Then I should see "user_k"
    And I should see "You are already on the LAST page."
