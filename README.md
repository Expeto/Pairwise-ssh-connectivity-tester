# Pairwise-ssh-tester

Given a list of hosts, this script will test the ssh connectivity between them. Ssh connection will be checked between every two hosts in the file.

## Config
Just edit the top of script and modify the hosts.txt address and server passwords. 

### Requirements
sshpass is required.

### Tips
You can also get more presentable html files for your outputs with a simple pipe.

```bash
./test.sh | aha --black > test_result.htm
```
