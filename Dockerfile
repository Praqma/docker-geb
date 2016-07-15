FROM selenium/standalone-firefox

USER root
RUN  adduser --disabled-password --gecos '' jenkins
RUN chown -R jenkins:jenkins -R /home/jenkins

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

RUN apt-get update \
	&& apt-get install -y zlib1g-dev \
	&& apt-get -y install libssl-dev \
	&& apt-get -y install build-essential \
	&& apt-get install -y cmake \
	&& apt-get install -y wget \
	&& apt-get install -y git \
	&& apt-get install -y openssh-server

RUN mkdir /home/jenkins/setup
WORKDIR /home/jenkins/setup

RUN wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.0.tar.gz
RUN tar -xzf ruby-2.3.0.tar.gz
RUN pwd && ls -la && ls ./ruby-2.3.0/ -la
RUN ./ruby-2.3.0/configure 
RUN make install
RUN gem install docopt
RUN gem install github-pages -v 51


# setting a propper charset to avoid https://github.com/jekyll/jekyll/issues/4268
#
## Install program to configure locales
#RUN dpkg-reconfigure locales
#RUN locale-gen C.UTF-8
#RUN /usr/sbin/update-locale LANG=C.UTF-8
## Install needed default locale for Makefly
#RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
#RUN locale-gen
## Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

COPY run.sh /home/jenkins/
RUN mkdir /home/jenkins/site
RUN mkdir /home/jenkins/site/_site
#RUN chmod 775 /home/jenkins/site/_site

EXPOSE 4444
