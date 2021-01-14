#!/bin/bash

# Creating a Github repo without using the website
git init && git add . && git commit --allow-empty -m "Initial commit"
hub create "lab-xxx/lab-template" -d "XXX Learning Lab"
git push --set-upstream origin master
