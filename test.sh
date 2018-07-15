#!/usr/bin/env bash

input="hosts.txt"
password="Passwd1"


RED='\e[31m'
NC='\033[0m' # No Color


while IFS= read -r host

do
  problem=0
  echo -e "\n=============================================================================== "
  echo -e "\e[0;31;47m $host \e[0m is being tested"
  status_of_host="$(ping -c 1 "$host" > /dev/null ; echo $? )"

  if [ $status_of_host -ne 0 ]
  then
	  echo "HOST SEEMS TO BE DOWN!!!!!!"
  else
  
 
 connectivity_result="$(/usr/bin/sshpass -p "$password" ssh -n -o UserKnownHostsFile=/dev/null -o PreferredAuthentications=password -o StrictHostKeyChecking=no profelis@"$host" ping -c 1 www.google.com >> /dev/null ; echo $? )"

  if [ $connectivity_result -ne 0 ]
  then
       echo -e "Does not have an internet connection!!!!"
  fi
  
  while IFS= read -r sshtarget
    do
	    ssh_result=$(sshpass -p "asdasd123" ssh -q -n -t  -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null profelis@$host "/usr/bin/sshpass -p $password ssh -q  -o StrictHostKeyChecking=no -o PreferredAuthentications=password -o ConnectTimeout=5 profelis@$sshtarget "exit ; echo $?" " )
	    echo -n "Checking ssh connection to "
	    echo -n "$sshtarget , $ssh_result "
    if [ $ssh_result -ne 0 ]
    then
	    echo  -e "\033[33;7m Cannot ssh to $sshtarget from $host  \033[0m"
    else
	    echo -e "\e[0;32m Success! \e[0m"
    fi
    done < "$input"
fi
done < "$input"
