#!/bin/bash  -xue

package_name=$1
target_name=$2
shift  2

if [[ $# -ge 1 ]] ; then
    output_file=$1
    shift  1
else
    output_file='./data/pbspro.build.tar.bz2'
fi

docker_cmd='docker'

volume_host_def=$(realpath ../data/build)
volume_mount=${VOLUME_MOUNT:-'/tmp/pbspro'}
volume_hostdir=${VOLUME_HOSTDIR:-"$(realpath ../data/build)"}
volume_option="${volume_hostdir}:${volume_mount}"

container_name='compile-pbspro'

${docker_cmd} run               \
    --interactive               \
    --tty                       \
    --volume  ${volume_option}  \
    --name  ${container_name}   \
    ${package_name}             \
    "$@"
retErr=$?

if [[ -f ${output_file} ]] ; then
    ${docker_cmd} rm ${container_name}
fi

if [[ ${retErr} -eq 0 ]] ; then
    touch ${target_name}
fi

exit ${retErr}
