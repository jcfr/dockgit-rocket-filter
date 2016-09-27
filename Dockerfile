FROM ubuntu:14.04
MAINTAINER Jean-Christophe Fillion-Robin "jchris.fillionr@kitware.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install \
  mono-complete \
  unzip \
  curl \
  runit \
  && apt-get -y clean

RUN curl -LO https://github.com/xoofx/GitRocketFilter/releases/download/v1.1.1/git-rocket-filter-v1.1.1.zip && \
  unzip git-rocket-filter-v1.1.1.zip -d git-rocket-filter && \
  rm git-rocket-filter-v1.1.1.zip

ENTRYPOINT ["/usr/share/git-rocket-filter/entrypoint.sh", "mono", "/usr/share/git-rocket-filter/git-rocket-filter.exe"]

COPY imagefiles/entrypoint.sh /usr/share/git-rocket-filter/

WORKDIR /work
