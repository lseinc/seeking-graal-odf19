# base image with OpenJDK 11 Slim only
FROM openjdk:11-jdk-stretch
# set labels
MAINTAINER ddlucas@lse.com
VOLUME /tmp

WORKDIR /dockerjava
RUN mkdir -p /opt /dockerjava
RUN useradd -G sudo -ms /bin/bash dockerjava 
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y gcc clang llvm time zlib1g-dev curl vim openssl zip libncurses5-dev libncurses5 sudo file
RUN echo "root:graalvm" | chpasswd
RUN echo "dockerjava:graalvm" | chpasswd

ENV GRAALVM_VERSION=19.2.1
ENV GRAALVM_BINARY=graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
ENV GRADLE_VERSION=5.6.3
ENV GRADLE_BINARY=gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME=/opt/gradle
EXPOSE 8080
EXPOSE 8085
EXPOSE 8088
EXPOSE 3000

COPY etc/cacerts /etc/ssl/certs/java

COPY etc/bash_aliases /home/dockerjava/.bash_aliases
RUN  echo ". ~/.bash_aliases" >> /home/dockerjava/.bashrc
COPY tmp/$GRADLE_BINARY /opt/
COPY tmp/$GRAALVM_BINARY /opt/
RUN sync && ls -l /opt
RUN echo "before tar zfvx /opt/$GRAALVM_BINARY -C /opt"
RUN tar zfvx /opt/${GRAALVM_BINARY} -C /opt --delay-directory-restore || tar zfvx /opt/${GRAALVM_BINARY} -C /opt --delay-directory-restore 
RUN ls -l /opt
RUN unzip -x /opt/${GRADLE_BINARY} -d /opt
RUN rm -f /opt/*.tgz /opt/*.zip
RUN ls -l /opt

COPY README* /dockerjava
COPY etc /dockerjava/etc
COPY 01-hello-poly /dockerjava/01-hello-poly
COPY 02-fizzbuzz /dockerjava/02-fizzbuzz
COPY 03-functionalGraphDemo /dockerjava/03-functionalGraphDemo
COPY 04-speed /dockerjava/04-speed
COPY 05-llvm /dockerjava/05-llvm
COPY 06-reflect /dockerjava/06-reflect
COPY 07-spring-kofu /dockerjava/07-spring-kofu
COPY 07-ktor /dockerjava/07-ktor
RUN ls -l /dockerjava

RUN ( . etc/setup-jdk11.env && cd /dockerjava/07-spring-kofu && ./gradlew build )
RUN ( . etc/setup-jdk11.env && cd /dockerjava/07-ktor && ./gradlew build )
RUN ( mv /root/.gradle /home/dockerjava/.gradle  )
RUN chown -R dockerjava /dockerjava /opt /home/dockerjava
USER dockerjava

