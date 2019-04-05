Command to run jenkins as a docker container:
```bash
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -u 1000:999 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker -v usr/local/bin/go:/usr/local/bin/go -v /home/ankit/password.txt:/password.txt jenkins/jenkins:lts
```
