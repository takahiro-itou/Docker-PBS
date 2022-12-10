#!/bin/bash  -xue

package_name=$1
shift  1

build_pkg='./build/pbspro.build.tar.bz2'

docker_cmd='docker'

volume_host_def=$(readlink -f ./build)
volume_mount=${VOLUME_MOUNT:-'/tmp/pbspro'}
volume_hostdir=${VOLUME_HOSTDIR:-"${volume_host_def}"}
volume_option="${volume_hostdir}:${volume_mount}"

${docker_cmd} build                 \
    --target runtime                \
    --tag ${package_name}           \
    .
