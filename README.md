# Pathology-Lab-Management

Author - Vivek Sourabh,CSE(Part-III), Roll No. 14075059

The following portal manages a Pathology Laboratory.
The portal has been implemented using Django(a python based web develpment framework) and MySQL(one of the most commonly used Database Managemnet Systems).

There are four types of users on this portal:
	1). User
	2). Nominee
	3). Agent
	4). Admin

The functionality of all these four agents are as follows:
	1). Users: These are the people who sign up themselves on the portal and register for tests.
			Users have the privilege of registering a nominee(a person who cannot register by himself but will be registerd by the user instead).
			The user can book a test, register a nominee, update his own profile, view the tests he has registered for and also the the ones he registered in the past and their results have been declared.

	2). Nominee: Has only one one functionality i.e to to track the test he/she has been registered for.

	3). Agent : They are responsible for carrying out the test process for the tests that are assigned to them. As soon a a test is 			registerd an agent is assigned to it. The agent has the details of the patient and the patient can access the details 			  of the the agent. They can get in touch and discuss convinient timings for both. The agent is responsilbe for ensuring 			 the completion of test before the given due date.
				The agent updates the steps in the process as they are carried out.
				The agent can also apply for leaves which in goes as requests to admin who has the right to sanction or deny it.

	4). Admin : The admin has the right to add/remove agents from the portal and also sanction their leaves.
				The admin can also monitor the work of each agent.

To us the the portal the various users need to sign in using their respective email id's and usernames.
