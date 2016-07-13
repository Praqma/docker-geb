FROM selenium/standalone-firefox

USER root

# Groovy install
ENV         GROOVY_VERSION 2.4.3
ENV         PATH $PATH:/opt/groovy/current/bin
ENV         JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN         apt-get update -qq -y && \
            apt-get install -y patch wget unzip openjdk-8-jre-headless && \
            wget http://dl.bintray.com/groovy/maven/groovy-binary-${GROOVY_VERSION}.zip && \
            mkdir -p /opt/groovy && \
            unzip groovy-binary-${GROOVY_VERSION}.zip -d /opt/groovy && \
            ln -s /opt/groovy/groovy-${GROOVY_VERSION} /opt/groovy/current && \
            rm groovy-binary-${GROOVY_VERSION}.zip && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY geb.groovy /home/seluser/

EXPOSE 4444
