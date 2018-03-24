FROM ubuntu:14.04
MAINTAINER Jean-Christophe Fillion-Robin "jchris.fillionr@kitware.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && apt-get -y install \
  mono-complete \
  unzip \
  curl \
  runit \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean --yes

RUN \
  cd /usr/share && \
  curl -LO https://github.com/xoofx/GitRocketFilter/releases/download/v1.1.1/git-rocket-filter-v1.1.1.zip && \
  unzip git-rocket-filter-v1.1.1.zip -d git-rocket-filter && \
  rm git-rocket-filter-v1.1.1.zip

ENTRYPOINT ["/usr/share/git-rocket-filter/entrypoint.sh", "mono", "/usr/share/git-rocket-filter/git-rocket-filter.exe"]

COPY imagefiles/entrypoint.sh /usr/share/git-rocket-filter/

WORKDIR /work

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.description="Dockerized version of GitRocketFilter: Rewrite git branches in a powerful way." \
      org.label-schema.url="https://github.com/jcfr/dockgit-rocket-filter" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"
