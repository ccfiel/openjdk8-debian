FROM adoptopenjdk/openjdk8:jdk8u272-b10-debian

LABEL maintainer="ccfiel@bai.ph" version="2.0.2"
ARG ANDROID_COMPILE_SDK="29"
ARG ANDROID_BUILD_TOOLS="29.0.2"
ARG ANDROID_SDK_TOOLS="4333796"
ARG FLUTTER_VERSION="https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.22.2-stable.tar.xz"

RUN apt-get --quiet update --yes
RUN apt-get --quiet upgrade --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 bash python python-pip ruby-full ruby-dev git-all
RUN gem install fastlane -NV
RUN gem install google-api-client
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
RUN export ANDROID_HOME=$PWD/android-sdk-linux
RUN export PATH=$PATH:$PWD/android-sdk-linux/platform-tools/
RUN ["/bin/bash", "-c", "set +o pipefail"]
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
RUN ["/bin/bash", "-c", "set -o pipefail"]
RUN pip install firebase-admin
RUN pip install google-cloud-storage
RUN pip install google-cloud-firestore
