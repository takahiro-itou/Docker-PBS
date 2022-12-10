
##########################################################################
##
##    Arguments.
##
##########################################################################

##  Select Image Tag.
##    - 22.04 LTS   jammy
##    - 20.04 LTS   focal
##    - 18.04 LTS   bionic

ARG BASE_IMAGE_TAG='jammy'


##########################################################################
##
##    The 1st Stage.
##
##    Install Packages For PBS.
##
##########################################################################

# Pull Base Image.
FROM ubuntu:${BASE_IMAGE_TAG} AS basepkg

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
CMD [ "./BUILD.sh" ]

COPY ./scripts/build /work/build-pbs


##########################################################################
##
##    The 3rd Stage.
##
##    Install PBS From Built Package.
##
##########################################################################

#FROM basepkg AS runtime
FROM builder AS runtime

RUN :  \
    ; mkdir -p /work/build-pbs  \
    ; apt-get  install  \
        --no-install-recommends  --yes  \
        bzip2  \
        postgresql  \
        sendmail-bin  \
    ;

WORKDIR /work/build-pbs

ENTRYPOINT [ "/bin/bash" ]

COPY ./scripts/runtime /work/build-pbs
COPY ./build /work/build-pbs

RUN /bin/bash -xue ./INSTALL.sh
