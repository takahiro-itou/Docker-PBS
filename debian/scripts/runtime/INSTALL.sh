#!/bin/bash  -xue

bldpkg='pbspro.build.tar.bz2'

tar -xjvf ${bldpkg}

pushd pbspro/
make install
popd

/opt/pbs/libexec/pbs_postinstall
chmod 4755 /opt/pbs/sbin/pbs_iff /opt/pbs/sbin/pbs_rcp
