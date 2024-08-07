#!/bin/bash
#####################################################################################         
#
# USAGE: source dck-init
#
# logged in   | OK          | docker login, sets env for
#             |             | DOCKER_USER, DOCKER_PASSWORD
#             |             |
#             | NOK         | error message from docker login,                                
#             |             | env is cleared
#             |             |
# logged out  | n/a         | "please log out of docker first!"
#####################################################################################         

function login() {
	local _result=$1
	#echo logging $user into docker...
	local result=$(echo "$password" | docker login -u $user --password-stdin);

	if [[ "$_result" ]]; then 
		eval $_result="'$result'"
	else
		echo "$result"
	fi
}

function setEnv() {

	echo "setting environment..."
  export DOCKER_USER=$user
  export DOCKER_PASSWORD=$password
}

function clearEnv() {
	echo "clearing environment.."
	unset DOCKER_USER
	unset DOCKER_PASSWORD
}

function isLoggedIn() {
	local file="/home/$USER/.docker/config.json"
        local loggedIn
	local _result=$1

	if [[ -f $file ]]; then
		local auth=$(cat $file | jq '.auths."https://index.docker.io/v1/".auth')
		if [[ "$auth" = null ]]; then 
			loggedIn=false
		else
			loggedIn=true
		fi
	else
		loggedIn=false
	fi

	if [[ "$_result" ]]; then
		eval $_result="'$loggedIn'"
	else
		echo "$loggedIn"
	fi
}


#####################################################################################         
### MAIN SECTION ###
#####################################################################################         

# retrieve credentials from user
echo Dockerhub user name ?
read user
echo Dockerhub password? 
read -s password

# make sure credentials match auth token
loggedIn=$(isLoggedIn)
if [[ "$loggedIn" = true ]]; then
	echo "please log out of docker first!"
	return
fi

# login with credentials
loginResult=$(login)
echo "$loginResult"
if [[ "$loginResult" = "Login Succeeded" ]]; then
	setEnv
else
	echo "failure to log in user $user"
	clearEnv
fi
