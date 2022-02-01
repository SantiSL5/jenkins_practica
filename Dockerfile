FROM jenkins/jenkins:latest

USER root

RUN apt-get update
RUN apt-get -y install nodejs npm lsof