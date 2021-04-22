Install docker on your local machine 
open Terminal on your current folder project
 
1. build your docker image 
    docker build . -t  robot_framework_api
2.Use below command to run automation using tag
    docker run --shm-size=4g -e ROBOT_OPTIONS="-i API_Automation" -v "`pwd`"/reports:/opt/robotframework/reports:Z -v  "`pwd`"/../API_Automation:/opt/robotframework/tests:Z -e BROWSER=chrome -v  "`pwd`"/reports:/opt/robotframework/temp robot_framework_api:latest
    
 Note:--> Short description of docker run command
          -shm-size=4g--> Mentioned size to your docker container
          -e ROBOT_OPTIONS--> Mentioned Tags which you use in your project
          -v-->  mounting your test and reports path
          robot_framework_api:latest--> respective image name that you have given while building the image

