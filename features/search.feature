
Feature: searching to quickly find apps according to name/organization/description
    As a logged in user
    So that I can quickly find the app I'm looking for
    I should be able to search the app in the app listing page by name/organization/description

Background: Logged in
    Given the following apps exist:
        | name   | description             | org_id | status  | id |
        | app 1  | this is one test        | 1      | pending | 1  |
        | app 2  | this is two test        | 2      | pending | 2  |
        | app 3  | this is three test      | 3      | pending | 3  |

    And the following orgs exist:
        | name  | contact_id |
        | org A | 1          |
        | org B | 1          |
        | org C | 1          |

    And the following users exist:
        | name  | github_uid      | email         |
        | user 1 | esaas_developer| test@user.com |
        | user 2 | esaas_client   | test@client.com |
    
    # Notice model engagement ask for the presence of all for terms for engagement to be valid
    # otherwise it's destroyed automatically # BrUh...
    And the following engagements exist for "app 1":
        | app_id | semester    | coach_id | team_number | start_date |
        | 1      | FALL 2015   |    1     |    1        | 03/26      |
        | 1      | FALL 2016   |    1     |    1        | 03/26      |

    And the following engagements exist for "app 2": 
        | app_id | semester    | coach_id | team_number | start_date |
        |  2     | Spring 2016 |    1     |    1        | 03/26      |
        |  2     | FALL 2015   |    1     |    1        | 03/26      |

    And the following engagements exist for "app 3":
        | app_id | semester    | coach_id | team_number | start_date |
        |  3     | Spring 2015 |    1     |    1        | 03/26      |
        |  3     | Fall 2016   |    1     |    1        | 03/26      |

    And I'm logged in on the orgs page 

Scenario: No keyword
    Given I search for ""
    Then I should not see "app 1"
    And I should not see "user 1"
    And I should not see "org A"
    And I should see "Please enter a keyword in the search box"


Scenario: No filter
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Users"
    And I uncheck "Semesters"
    And I search for "1"
    Then I should not see "org A"
    And I should not see "user 1"
    And I should not see "app 1"
    And I should see "Please choose at least one category"


Scenario: search for an app by name keyword
    Given I uncheck "Organizations"
    And I uncheck "Users"
    And I uncheck "Semesters"
    And I search for "1"
    Then I should see "app 1"
    But I should not see "app 2"
    And I should not see "app 3"
    And I should see "org A"
    And I should not see "org B"
    And I should not see "org C"
    And I should not see "user 1"
    And I should not see "user 2"

    Given I uncheck "Organizations"
    And I uncheck "Users"
    And I uncheck "Semesters"
    And I search for "app"
    Then I should see "app 1"
    And I should see "app 2"
    And I should see "app 3"
    And I should see "org A"
    And I should see "org B"
    And I should see "org C"
    And I should not see "user 1"
    And I should not see "user 2"


Scenario: search for an app by description keyword
    Given I uncheck "Organizations"
    And I uncheck "Users"
    And I uncheck "Semesters"
    And I search for "three"
    Then I should see "app 3"
    But I should not see "app 1"
    And I should not see "app 2"
    And I should not see "org A"
    And I should not see "org B"
    And I should see "org C"
    And I should not see "user 1"
    And I should not see "user 2"

    Given I uncheck "Organizations"
    And I uncheck "Users"
    And I uncheck "Semesters"
    And I search for "test"
    Then I should see "app 1"
    And I should see "app 2"
    And I should see "app 3"
    And I should not see "user 1"
    And I should not see "user 2"


Scenario: search for an organization by keyword
    Given I uncheck "Apps"
    And I uncheck "Users"
    And I uncheck "Semesters"
    And I search for "org"
    Then I should see "org A"
    And I should see "org B"
    And I should see "org C"

    Given I uncheck "Apps"
    And I uncheck "Users"
    And I uncheck "Semesters"
    And I search for "B"
    Then I should see "org B"
    But I should not see "org A"
    And I should not see "org C"


Scenario: search for an user by keyword
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Semesters"
    And I search for "user"
    Then I should see "user 1"
    And I should see "user 2"

    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Semesters"
    And I search for "1"
    Then I should see "user 1"
    And I should not see "user 2"


Scenario: search for all four categories by keyword
    Given I search for "1"
    Then I should see "app 1"
    And I should see "user 1"
    And I should not see "user 2"


Scenario: search for engagement semesters only with semester
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Users"
    Then I search for "FALL 2015"
    Then I should see "app 1"
    And I should see "app 2"
    And I should not see "app 3"
    Then I search for "Spring 2016"
    Then I should see "app 2"
    And I should not see "app 1"
    And I should not see "app 3"
    
Scenario: search for engagement semesters with all checked
    Given I search for "FALL 2016"
    Then I should see "app 1"
    And I should not see "app 2"
    And I should see "app 3"

Scenario: search for engagement semesters with fuzzy input semester
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Users"
    Then I search for "fa"
    Then I should see "app 1"
    And I should see "app 2"
    And I should see "app 3"

    Given I search for "spring"
    Then I should not see "app 1"
    And I should see "app 2"
    And I should see "app 3"


Scenario: search for engagement semesters with fuzzy input year
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Users"
    And I search for "15"
    Then I should see "app 1"
    And I search for "2015"
    Then I should see "app 1"
    Then I should see "app 2"
    Then I should see "app 3"

    Given I search for "2013"
    Then I should not see "app 1"
    Then I should not see "app 2"
    Then I should not see "app 3"

Scenario: search for engagement semesters only with fuzzy input semester and year
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Users"
    And I search for "Fa15"
    Then I should see "app 1"
    Then I should see "app 2"
    Then I should not see "app 3"
    

