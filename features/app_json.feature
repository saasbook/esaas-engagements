Feature: users can retrieve app list as json
	As a user who wants to use our RESTful APIs
	So that I can retrieve apps list without accessing html
	I want to get json file instead

Background: apps with different status exist
    Given the following orgs exist:
        | name | contact_id |
        | org1 | 1          |

	And the following apps exist:
        | name  | description	| org_id | repository_url |status  		|
        | app1  | test1       	| 1      | test1@test.com | development |
        | app2  | test2      	| 1      | test2@test.com | pending 	|
        | app3  | test3       	| 1      | test3@test.com | in_use 		|


Scenario: List of featured apps in JSON
	When I visit "/apps.json"
	Then the response should be:
		"""
		[{"id":1,"name":"app1","description":"test1","deployment_url":null,"repository_url":"test1@test.com","org":{"name":"org1","url":null}},{"id":3,"name":"app3","description":"test3","deployment_url":null,"repository_url":"test3@test.com","org":{"name":"org1","url":null}}]
		"""