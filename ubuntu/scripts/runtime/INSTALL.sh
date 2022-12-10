#!/bin/bash  -xue

bldpkg='pbspro.build.tar.bz2'

tar -xjvf ${bldpkg}

pushd pbspro/
make install
popd
