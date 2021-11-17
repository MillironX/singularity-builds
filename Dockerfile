FROM alpine:3.14.3

LABEL base.image="alpine:3.14.3"
LABEL software="NanoSim"
LABEL software.version="3.0.2"
LABEL dockerfile.version="3"
LABEL description="Fast and scalable read simulator that captures the technology-specific features of ONT data."
LABEL website="https://github.com/bcgsc/NanoSim"
LABEL license="https://github.com/bcgsc/NanoSim/blob/master/LICENSE"
LABEL maintainer="Thomas A. Christensen II"
LABEL maintainer.email="25492070+MillironX@users.noreply.github.com"

ARG NANOSIM_VERSION=3.0.2
ARG MINIMAP2_VERSION=2.18
ARG LAST_VERSION=916
ARG LAST_SHA="98fc3d382ef443b4468b633d2fe90ac3d0b3c21e"
ARG SAMTOOLS_VERSION=1.12
ARG GENOMETOOLS_VERSION=1.6.2

RUN \
  # Install real dependencies
  apk add --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
  --update --no-cache \
    bash \
    libbz2 \
    ncurses \
    openblas-dev \
    py3-pip \
    py3-wheel \
    python3 \
    cython \
    xz \
    zlib && \
\
  # Install Python packages available from apk
  apk add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --update --no-cache \
    py3-six \
    py3-joblib \
    py3-threadpoolctl \
    py3-numpy \
    py3-numpy-dev \
    py3-scipy \
    py3-scikit-learn && \
\
  # Install build dependencies
  apk add --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    --no-cache --virtual .build-deps \
    blas-dev \
    build-base \
    bzip2-dev \
    freetype-dev \
    g++ \
    gcc \
    gfortran \
    git \
    lapack-dev \
    libgfortran \
    libpng-dev \
    make \
    musl-dev \
    ncurses-dev \
    py-pip \
    python3-dev \
    wget \
    xz-dev \
    zlib-dev &&\
\
  # Make python3 the default
  ln -fs /usr/include/locale.h /usr/include/xlocale.h && \
  ln -fs /usr/bin/python3 /usr/local/bin/python && \
  ln -fs /usr/bin/pip3 /usr/local/bin/pip && \
\
  # Download and install Minimap2
  cd /tmp && \
  wget -qO- https://github.com/lh3/minimap2/releases/download/v${MINIMAP2_VERSION}/minimap2-${MINIMAP2_VERSION}.tar.bz2 | tar xjv && \
  cd minimap2-${MINIMAP2_VERSION} && \
  make && \
  cp minimap2 /usr/bin && \
  mkdir /usr/man && \
  cp minimap2.1 /usr/man && \
  cd .. && \
  rm -rf minimap2-${MINIMAP2_VERSION} && \
  cd && \
\
  # Download and install LAST
  cd /tmp && \
  git clone https://gitlab.com/mcfrith/last.git && \
  cd last && \
  git checkout ${LAST_SHA} && \
  make && make install && \
  cd .. && \
  rm -rf last && \
  cd && \
\
  # Download and install samtools
  cd /tmp && \
  wget https://github.com/samtools/samtools/releases/download/$SAMTOOLS_VERSION/samtools-$SAMTOOLS_VERSION.tar.bz2 && \
  tar xjvf samtools-$SAMTOOLS_VERSION.tar.bz2 && \
  cd samtools-$SAMTOOLS_VERSION && \
  ./configure && \
  make && make install && \
  cd .. && \
  rm -rf samtools-$SAMTOOLS_VERSION* && \
  cd && \
\
  # Download and install GenomeTools
  cd /tmp && \
  wget -qO- https://github.com/genometools/genometools/archive/refs/tags/v${GENOMETOOLS_VERSION}.tar.gz | tar xzv && \
  cd genometools-${GENOMETOOLS_VERSION} && \
  make cairo=no errorcheck=no && make cairo=no errorcheck=no install && \
  cd .. && \
  rm -rf v${GENOMETOOLS_VERSION} && \
  cd && \
\
  # Download and install Python packages from pip
  pip3 install -v --no-cache-dir pysam==0.17 && \
  pip3 install -v --no-cache-dir HTSeq==0.11.2 && \
  pip3 install -v --no-cache-dir pybedtools==0.8.2 && \
\
  # Download and install NanoSim
  cd /tmp && \
  wget -qO- https://github.com/bcgsc/NanoSim/archive/refs/tags/v${NANOSIM_VERSION}.tar.gz | tar xzv && \
  cd NanoSim-${NANOSIM_VERSION} && \
  cp -r src/* /usr/bin && \
  cd .. && \
  rm -rf NanoSim-${NANOSIM_VERSION} && \
  cd .. && \
\
  # Cleanup build packages
  apk del --no-cache .build-deps && \
  rm -vrf /var/cache/apk/*
