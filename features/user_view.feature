Feature: having a profile page for each user
	As a coach of an engagement
    So that I can easily access to contact information of a customer/student
    I want to add a details page for each user

Background: Logged in
    Given the following users exist:
        | id | name         | github_uid      | email                     | user_type |
        | 1  | Armando Fox  | armandofox      | fox@berkeley.edu          | coach     |
        | 2  | Joe Deatrick | jldeatrick      | jldeatrick@protonmail.com | client    |
        | 3  | Developer    | esaas_developer | esaas@saasbook.info       | student   |

    And the following orgs exist:
        | id | name         | contact_id |
        | 1  | ACElab       | 1          |
        | 2  | QDGames      | 2          |

    Given the following apps exist:
        | id | name         | description        | org_id | status  |
        | 1  | Teamscope    | praying for fix    | 1      | pending |
        | 2  | Chromaticats | never gonna finish | 2      | pending |

    And the following engagements exist:
        | id | app_id | coach_id | team_number | start_date | student_names           |
        | 1  | 1      | 1        | 169         | 2017-10-01 | adnan hemani, wayne li  |
        | 2  | 2      | 1        | 178         | 2017-11-02 | Zhi Zhang               |

    And I'm logged in on the orgs page

# Story ID: 153070288
Scenario: User view displays the correct names
    Given I am on the Users page
    Then I should see "Joe Deatrick"
    And I should see "Armando Fox"
    And I should not see "Jackson Murphy"

# Story ID: 153070288
Scenario: Each User has a clickable link to their profile page
    Given I am on the Users page
    And I follow "Joe Deatrick"
    Then I should be on the user details page for "Joe Deatrick"

# Story ID: 153070288
Scenario: The User profile page should have the correct information
    Given I am on the user details page for "Joe Deatrick"
    Then I should see "jldeatrick@protonmail.com"
    And I should see "Client"
    And I should see "2017-11-02"
    And I should see "178"
    And I should see "Armando Fox"
    And I should not see "ACElab"
    And I should not see "Teamscope"

