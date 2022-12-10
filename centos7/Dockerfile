
ARG BASE_IMAGE_TAG='7'

##########################################################################
##
##    The 1st stage.
##
##    Install base packages.
##
##########################################################################

# Pull base image
FROM centos:${BASE_IMAGE_TAG} AS basepkg

RUN :  \
    ; yum install -y  \
        emacs  \
        expat  \
        git  \
        libcgroup  \
        libcgroup-tools  \
        libedit  \
        libical  \
        make  \
        postgresql-contrib  \
        python  \
        python3  \
        sudo  \
        tcl  \
        time  \
        tk  \
        vi  \
    ;

##########################################################################
##
##    The 2nd stage.
##
##    Build PBS.
##
##########################################################################

FROM basepkg AS builder

RUN :  \
    ; mkdir -p /work/build-pbs  \
    ; yum install -y  \
        autoconf  \
        automake  \
        expat-devel  \
        gcc  \
        gcc-c++  \
        hwloc-devel  \
        libedit-devel  \
        libical-devel  \
        libtool  \
        libX11-devel  \
        libXext  \
        libXft  \
        libXt-devel  \
        ncurses-devel  \
        openssl-devel  \
        perl  \
        postgresql-devel  \
        python3-devel  \
        python-devel  \
        rpm-build  \
        swig  \
        tcl-devel  \
        tk-devel  \
    ;

WORKDIR /work/build-pbs

COPY ./scripts/build /work/build-pbs

ENTRYPOINT [ "/bin/bash" ]
CMD [ "./BUILD.sh" ]

##########################################################################
##
##    The 3rd stage.
##
##    Install PBS.
##
##########################################################################

#FROM basepkg AS runtime
FROM builder AS runtime

RUN :  \
    ; mkdir -p /work/build-pbs  \
    ; yum install -y  \
        bzip2  \
        postgresql-server  \
        sendmail  \
    ;

WORKDIR /work/build-pbs

COPY ./scripts/runtime /work/build-pbs

RUN /bin/bash -xue ./INSTALL.sh

ENTRYPOINT [ "/bin/bash" ]
