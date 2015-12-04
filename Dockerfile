FROM discoenv/javabase

USER root
VOLUME ["/etc/iplant/de"]

COPY conf/main/logback.xml /home/iplant/
COPY target/metadata-standalone.jar /home/iplant/

ARG git_commit=unknown
ARG buildenv_git_commit=unknown
ARG version=unknown
LABEL org.iplantc.de.metadata.git-ref="$git_commit" \
      org.iplantc.de.metadata.version="$version" \
      org.iplantc.de.buildenv.git-ref="$buildenv_git_commit"

RUN ln -s "/opt/jdk/bin/java" "/home/iplant/bin/metadata"
ENTRYPOINT ["metadata", "-Dlogback.configurationFile=/etc/iplant/de/logging/metadata-logging.xml", "-cp", ".:metadata-standalone.jar:/home/iplant/", "metadata.core"]
CMD ["--help"]

