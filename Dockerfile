FROM adoptopenjdk/openjdk8:jdk8u272-b10-debian

LABEL maintainer="ccfiel@bai.ph" version="2.0.2"

RUN apt-get update
RUN apt-get upgrade
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 bash python python-pip ruby-full ruby-dev
RUN pip install firebase-admin
RUN pip install google-cloud-storage
RUN pip install google-cloud-firestore
RUN gem install fastlane -NV
RUN gem install google-api-client
