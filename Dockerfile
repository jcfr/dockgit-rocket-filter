FROM ubuntu:18.04
MAINTAINER Jean-Christophe Fillion-Robin "jchris.fillionr@kitware.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && apt-get -y install \
    mono-complete \
    unzip \
    curl \
    runit

RUN \
  cd /usr/src && \
  GITROCKET_GIT_SHA=57715e534e415621403e90bfaf59f6115a75458c && \
  curl -L https://github.com/xoofx/GitRocketFilter/archive/$GITROCKET_GIT_SHA.zip -o GitRocketFilter.zip && \
  unzip GitRocketFilter.zip && rm GitRocketFilter.zip && \
  mv GitRocketFilter-$GITROCKET_GIT_SHA GitRocketFilter && \
  cd GitRocketFilter && \
  #
  # Fix error: "This project references NuGet package(s) that are missing on this computer. Enable NuGet Package Restore to download them."
  #
  curl -LO https://dist.nuget.org/win-x86-commandline/latest/nuget.exe && \
  mono nuget.exe restore && \
  #
  # Fix error: "CSC: error CS0041: Unexpected error writing debug information -- 'Operation is not supported on this platform.'"
  #
  sed -i "s/pdbonly/none/" src/GitRocketFilter.csproj && \
  #
  # Build
  #
  xbuild /tv:4.0 /t:Build /fl "/p:Configuration=Release;Platform=Any CPU" && \
  #
  # Install libcurl3 required by 'libgit2-4d6362b.so'
  #
  #   Associated error message was:
  #
  #      System.TypeInitializationException: The type initializer for 'LibGit2Sharp.Core.NativeMethods' threw an exception.
  #      ---> System.DllNotFoundException: libsnative/linux/amd64/libgit2-4d6362b.so"
  #
  #   Using LD_DEBUG=all allowed to track this done. It reported message like "version `CURL_OPENSSL_3' not found" when
  #   trying to load 'libgit2-4d6362b.so'
  #
  apt-get install -y libcurl3 && \
  #
  # Install
  #
  mv bin/Release /usr/share/git-rocket-filter && \
  rm -rf /usr/src/GitRocketFilter && \
  #
  # Cleanup
  #
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean --yes


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
