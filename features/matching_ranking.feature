Feature: Test Ranking page feature
   As a student who is involved in the matching
   I want to go to matching page
   So that I can easily choose my preference for projects

   Background: Users and apps have been added to database
      Given the following apps exist:
         | name | description | org_id | status  |
         | App1 | test        | 1      | pending |
         | App2 | test        | 1      | pending |
         | App3 | test        | 1      | pending |
         | App4 | test        | 1      | pending |

      And the following users exist:
         | id | name  | github_uid      | email          | user_type |
         | 1  | user1 | esaas_developer | test@user.com  | coach     |
         | 2  | user2 |                 | test1@user.com | student   |
         | 3  | user3 |                 | test2@user.com | student   |

      Given I am on the login page
      And I follow "Log in with GitHub"
      And I am on the matching page
      Then I want to create matching with "2" engagements
      Then I fill in "Matching Name" with "Matching 1"
      And I select "App1" from "App Names"
      And I select "App2" from "App Names"
      And I fill in "1) Team Number/Name" with "Team1"
      And I select "user1" from "1) Coach"
      And I select "user2" from "1) Students"
      And I fill in "2) Team Number/Name" with "Team2"
      And I select "user1" from "2) Coach"
      And I select "user3" from "2) Students"
      And I press "Submit"
      Then I visit "/matching"
      
   @javascript
   Scenario: Coach can see matching info created 
      And I visit "/matching"
      Then I follow "Matching 1"
      Then I should see "Not responded yet"
      Then I follow "Team1"
      Then I should see "Your team has not responded yet!"
      Then I want to submit ranking preference
      # Then I should not see "Your team has not responded yet!"
      Then I follow "Back"
      Then I visit "/matching"

      
      