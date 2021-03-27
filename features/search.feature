
Feature: searching to quickly find apps according to name/organization/description
    As a logged in user
    So that I can quickly find the app I'm looking for
    I should be able to search the app in the app listing page by name/organization/description

Background: Logged in
    Given the following apps exist:
        | name   | description             | org_id | status  |
        | app 1  | this is one test        | 1      | pending |
        | app 2  | this is two test        | 2      | pending |
        | app 3  | this is three test      | 3      | pending |

    And the following orgs exist:
        | name  | contact_id |
        | org A | 1          |
        | org B | 1          |
        | org C | 1          |

    And the following users exist:
        | name  | github_uid      | email         |
        | user 1 | esaas_developer| test@user.com |
        | user 2 | esaas_client   | test@client.com |
    
    And the following engagements exist for "app 1":
        | app_id | semester    |
        | 1 | FALL 2016   |
        | 1 | FALL 2015   |

    And the following engagements exist for "app 2": 
        | semester    |
        | Spring 2016 |
        | FALL 2015   |

    And the following engagements exist for "app 3":
        | semester    |
        | FALL 2016   |
        | Spring 2015 |

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
    # Given I uncheck "Apps"
    # And I uncheck "Organizations"
    # And I uncheck "Users"
    Then I search for "fa"
    Then I should see "app 1"
    # And I should see "app 2"
    # And I should see "app 3"
    # Then I search for "spring"
    # Then I should see "app 2"
    # And I should see "app 3"
    # And I should not see "app 1"

Scenario: search for engagement semesters only with year
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Users"
    And I search for "15"
    # Then I should see "app 1"
    # Then I search for "2013"
    # Then I should see "app 3"

Scenario: search for engagement semesters only with semester and year
    Given I uncheck "Apps"
    And I uncheck "Organizations"
    And I uncheck "Users"
    And I search for "SPRING 2013"
    Then I should see "app 3"
    # And I search for "Fa15"
    # Then I should see "app 1"
    

