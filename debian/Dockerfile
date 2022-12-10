
##########################################################################
##
##    Arguments.
##
##########################################################################

##  Select Image Tag.
ARG BASE_IMAGE_TAG='11.4-slim'

##########################################################################
##
##    The 1st Stage.
##
##    Install Packages For PBS.
##
##########################################################################

# Pull Base Image.
FROM debian:${BASE_IMAGE_TAG} AS basepkg

RUN :  \
    ; apt-get  update   \
    ; apt-get  install  \
        --no-install-recommends  --yes  \
        emacs  \
        expat  \
        git  \
        cgroup-tools  \
        libedit2  \
        libical3  \
        make  \
        postgresql-contrib  \
        python2  \
        python3  \
        sudo  \
        tcl  \
        time  \
        tk  \
        vim  \
    ;

##########################################################################
##
##    The 2nd Stage.
##
##    Build PBS.
##
##########################################################################

FROM basepkg AS builder

RUN :  \
    ; mkdir -p /work/build-pbs  \
    ; apt-get  install  \
        --no-install-recommends  --yes  \
        autoconf  \
        automake  \
        gcc  \
        g++  \
        libedit-dev  \
        libexpat-dev  \
        libhwloc-dev  \
        libical-dev  \
        libssl-dev  \
        libx11-dev  \
        libxext-dev  \
        libxft-dev  \
        libxt-dev  \
        ncurses-dev  \
        perl  \
        postgresql-server-dev-all  \
        python3-dev  \
        python-dev  \
        swig  \
        tcl-dev  \
        tk-dev  \
    ;

WORKDIR /work/build-pbs

ENTRYPOINT [ "/bin/bash" ]

