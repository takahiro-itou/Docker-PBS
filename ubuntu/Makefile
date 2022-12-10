
USER_NAME     =  takahiroitou
PROJECT_NAME  =  pbspro-ubuntu
PACKAGE_NAME  =  ${USER_NAME}/${PROJECT_NAME}
PACKAGE_TAG   =  jammy

DOCKER_CMD    =  docker

DEPS_DIR      =  .deps
SOURCE_DIR    =  .

##########################################################################
##
##    フォニーターゲット。
##

.PHONY  :  all  clean-all

all :
	${MAKE}  build-basepkg

##########################################################################
##
##    依存関係。
##

##########################################################################
##
##    ビルドターゲット。
##

build-basepkg   :
	${DOCKER_CMD} build     \
	    --target basepkg    \
	    --tag ${PACKAGE_NAME}:${PACKAGE_TAG}    \
	    ${SOURCE_DIR}

##########################################################################
##
##    クリーンターゲット。
##
