@wip
Feature: User can add a profile picture that shows up in User details page/comments
	As a user of the app
	So that I can easily communicate with other users
	I want to be able to upload a profile picture and see it on the users page

Background:
	Given the following images exist:
		| directory         | filename    | extension |
		| app/assets/images | ArmandoFox  | png       |
		| app/assets/images | AdnanHemani | jpeg      |
		| app/assets/images | _default    | png       |
		| app/assets/images | randomImage | bmp       |
		| app/assets/images | notanimage  | txt       |
		| app/assets/images | notjsagain  | js        |
		| app/assets/images | haterspec   | rb        |

	And the following users exist:
		| name            | github_uid      | email                         |
		| ESaaS Developer | esaas_developer | esaas_developer@saasbook.info |
		| Armando Fox     | armandofox      | fox@berkeley.edu              |
		| Adnan Hemani    | adnanhemani     | adnan.h@berkeley.edu          |

	And the follwing orgs exist:
		| name                     | contact_id |
		| UC Berkeley CS169        | 3          |
		| Armando's Secret Society | 2          |

	And the following apps exist:
		| name      | description | status  |
		| AFX Dance | good stuff  | pending |

	And I am logged in
	And I follow "Users" within "#nav_header"

# Story ID: 153069541
Scenario: Each user has a default profile image
	When I follow "Armando Fox"
	Then I should see "/assets/_default.png"
	When I follow "Users" within "#nav_header"
	And I follow "Adnan Hemani"
	Then I should see "/assets/_deafult.png"

# Story ID: 153069541
Scenario: Each user can upload a image by local file
	When I follow "Armando Fox"
	And I follow "Edit User"
	Then I should see "Upload Profile Image"
	When I attach the file "app/assets/images/ArmandoFox.png" to "Upload Profile Image"
	And I press "Upload Image"
	Then I should be on the User page for "Armando Fox"
	And I should see "ArmandoFox"

# Story ID: 153069541
Scenario: User can upload a valid image file (happy path)
	When I follow "Armando Fox"
	And I follow "Edit User"
	When I attach the file "app/assets/images/randomImage.bmp" to "Upload Profile Image"
	And I press "Upload Image"
	Then I should be on the User page for "Armando Fox"
	And I should see "randomImage"

# Story ID: 153069541
Scenario: User cannot upload an invalid image file (sad path)
	When I follow "Armando Fox"
	And I follow "Edit User"
	When I attach the file "app/assets/images/notanimage.txt" to "Upload Profile Image"
	And I press "Upload Image"
	Then I should see "Not a valid image file"
	And I should be on the User page for "Armando Fox"

	When I attach the file "app/assets/images/notjsagain.js" to "Upload Profile Image"
	And I press "Upload Image"
	Then I should see "Not a valid image file"

	When I attach the file "app/assets/images/haterspec.rb" to "Upload Profile Image"
	And I press "Upload Image"
	Then I should see "Not a valid image file"

# Story ID: 153069541
Scenario: User profile picture is also shown on comments
	Given the user "Armando Fox" has a profile image "app/assets/images/ArmandoFox.png"
	And I go to the app details page for "AFX Dance"
	When I fill in "Write a comment..." with "AFX Dance is awesome!"
	And I press "Post"
	Then I should see "ArmandoFox"
