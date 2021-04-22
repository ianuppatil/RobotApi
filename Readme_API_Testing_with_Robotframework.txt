API Testing with Robotframework

1.Project Structure
	API_Test_Auto_AB[workspace folder]
		- API Automation Project
			- Resources
				- JSON 		[api request body]
				- TestData	[Property Files]
			    - All resources files
			- Testcases
				- All Test suites
			- Utils
				- Global_Resources
					- All Common files which are use in project
				- PythonLibarary
					- All Internal library

		- docker 
			- Scripts
			- Dockerfile
		- Drivers	
			- All Required Drivers 


Note :- In config File you need to mention your apikey,apiReadAccessToken,Uname and pass if required else cases will run with default parameters 

	  For running on local if you want store all logs use this command
	  	- robot -outputDir -T `pwd`/reports   `pwd`/API_Automation/Test_Cases/Movie_List_End_To_End_Flow.robot
   


    
