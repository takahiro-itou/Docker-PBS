#!/bin/bash  -xue

repo_url='https://github.com/openpbs/openpbs.git'
src_pkg='/tmp/pbspro/pbspro.tar.bz2'
trg_pkg='/tmp/pbspro/pbspro.build.tar.bz2'
rm='/bin/rm'

${rm} -f ${trg_pkg}

export GIT_SSL_NO_VERIFY=1
if [[ -f ${src_pkg} ]] ; then
    tar -xjvf ${src_pkg}
else
    git clone --recursive ${repo_url} -b v18.1.4 pbspro
fi

pushd pbspro/
./autogen.sh
./configure --prefix=/opt/pbs
make
popd

tar -cjvf ${trg_pkg} pbspro/
