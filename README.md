Splitting backend and frontend builds in Jenkins
================================================

proof of concept

Current approach
----------------

* Use just one repository
* Use multiple jenkinsfiles ("jobs")
* Assume that github trigger would run only the main job (application.jenkinsfile)
* It will build prerequisites ("backend" and "frontend") as a first parallel stage, using other jenkinsfiles
* It also would determine the caching keys ("versions") for the frontend and backend parts of the project, then pass it to the build jobs
* It could use latest SHA-1 of git commit which touched associated files for "version", but also
* Either main application.jenkinsfile or "downstream" ones would skip build if the previous build for the same version already happened
* Possibly wait for build to finish if the same downstream build is triggered by some other parallel PR or branch
* Possibly copy or refer somehow to logs and other artifacts of the "cached" downstream job

Local setup for fast iterations
-------------------------------

Mount or open docker volume for dockerized jenkins, create a folder "repos" in it.

Checkout this repository into that folder.

Create three "items" in the Jenkins: "application", "backend", "frontend", with type "Multibranch pipeline"

for all three:

branch sources > git > project repository: "/var/jenkins_home/repos/application/.git"

build configuration > "by jenkinsfile" > Script path: "application.jenkinsfile" (and "backend.jenkinsfile", and "frontend.jenkinsfile", accordingly)

This should be enough.

now, make a change in the repo, commit it locally, go to the jenkins, items, "application", "master", and push "Build now" to simulate external trigger from github.
