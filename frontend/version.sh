#!/bin/sh
# this returns SHA-1 of the commit which touched listed files last
git log -1 --pretty='%h' frontend.jenkinsfile frontend
