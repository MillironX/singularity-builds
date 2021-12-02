FROM ubuntu:focal

LABEL base.image="ubuntu:focal"
LABEL software="NanoSim"
LABEL software.version="3.0.2"
LABEL dockerfile.version="4"
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

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN \
  # Install real dependencies
  apt-get update && \
  apt-get install --no-install-recommends -y \
    build-essential \
    bzip2 \
    ca-certificates \
    curl \
    cython3 \
    gcc \
    git \
    gnuplot \
    libbz2-dev \
    libcurl4-gnutls-dev \
    liblzma-dev \
    libncurses5-dev \
    libssl-dev \
    make \
    perl \
    python3 \
    python3-pip \
    python3-dev \
    zlib1g-dev \
  && \
  apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN \
  # Make python3 the default
  update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
  update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

RUN \
  # Download and install Minimap2
  cd /tmp && \
  curl -L https://github.com/lh3/minimap2/releases/download/v${MINIMAP2_VERSION}/minimap2-${MINIMAP2_VERSION}.tar.bz2 | tar xjv && \
  cd minimap2-${MINIMAP2_VERSION} && \
  make && \
  cp minimap2 /usr/bin && \
  mkdir /usr/man && \
  cp minimap2.1 /usr/man && \
  cd .. && \
  rm -rf minimap2-${MINIMAP2_VERSION} && \
  cd

RUN \
  # Download and install LAST
  cd /tmp && \
  git clone https://gitlab.com/mcfrith/last.git && \
  cd last && \
  git checkout ${LAST_SHA} && \
  make && make install && \
  cd .. && \
  rm -rf last && \
  cd

RUN \
  # Download and install samtools
  cd /tmp && \
  curl -L https://github.com/samtools/samtools/releases/download/$SAMTOOLS_VERSION/samtools-$SAMTOOLS_VERSION.tar.bz2 | tar xvj && \
  cd samtools-$SAMTOOLS_VERSION && \
  ./configure && \
  make && make install && \
  cd .. && \
  rm -rf samtools-$SAMTOOLS_VERSION && \
  cd

RUN \
  # Download and install GenomeTools
  cd /tmp && \
  curl -L https://github.com/genometools/genometools/archive/refs/tags/v${GENOMETOOLS_VERSION}.tar.gz | tar xzv && \
  cd genometools-${GENOMETOOLS_VERSION} && \
  make cairo=no errorcheck=no && make cairo=no errorcheck=no install && \
  cd .. && \
  rm -rf v${GENOMETOOLS_VERSION} && \
  cd

# Download and install Python packages from pip
RUN pip3 install -v --no-cache-dir six==1.16.0
RUN pip3 install -v --no-cache-dir joblib==0.14.1
RUN pip3 install -v --no-cache-dir numpy==1.17.2
RUN pip3 install -v --no-cache-dir scipy==1.4.1
RUN pip3 install -v --no-cache-dir scikit-learn==0.21.3
RUN pip3 install -v --no-cache-dir pysam==0.17
RUN pip3 install -v --no-cache-dir HTSeq==0.11.2
RUN pip3 install -v --no-cache-dir pybedtools==0.8.2

RUN \
  # Download and install NanoSim
  cd /tmp && \
  curl -L https://github.com/bcgsc/NanoSim/archive/refs/tags/v${NANOSIM_VERSION}.tar.gz | tar xzv && \
  cd NanoSim-${NANOSIM_VERSION} && \
  cp -r src/* /usr/bin && \
  cd .. && \
  rm -rf NanoSim-${NANOSIM_VERSION} && \
  cd ..

ENTRYPOINT [ "/usr/bin/simulator.py" ]
