FROM alpine

ENV PERCONA_TOOLKIT_VERSION=${PERCONA_TOOLKIT_VERSION:-3.1.0}

RUN set -xe && \
  # Build dependencies
  apk add --no-cache --virtual .build-deps ca-certificates gcc make wget && \
  # Percona Toolkit
  apk add --no-cache \
  perl \
  perl-dbi \
  perl-dbd-mysql \
  perl-io-socket-ssl \
  perl-term-readkey && \
  wget -O /tmp/percona-toolkit.tar.gz https://www.percona.com/downloads/percona-toolkit/${PERCONA_TOOLKIT_VERSION}/source/tarball/percona-toolkit-${PERCONA_TOOLKIT_VERSION}.tar.gz && \
  tar -xzvf /tmp/percona-toolkit.tar.gz -C /tmp && \
  cd /tmp/percona-toolkit-${PERCONA_TOOLKIT_VERSION} && \
  perl Makefile.PL && \
  make && \
  make test && \
  make install && \
  # Cleanups
  apk del --no-network .build-deps && \
  rm -rf /tmp/percona-toolkit*
