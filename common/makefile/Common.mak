##  -*-  coding: utf-8-with-signature-unix; mode: makefile-gmake   -*-  ##

##########################################################################
##
##    変数宣言。
##

COMMON_DIR    ?=  ../common
DEPS          ?=  .deps
SOURCE_DIR    ?=  .
TARGET_PKGS   ?=  ./build/pbspro.build.tar.bz2

CHKIMG        :=  ${COMMON_DIR}/chkimg
COMPILE_PBS   :=  ${COMMON_DIR}/run-compile.sh
INSTALL_PBS   :=  ${COMMON_DIR}/run-install.sh

##########################################################################
##
##    フォニーターゲット。
##

.PHONY  :  all  clean-all

all :
	${MAKE}  update-deps
	${MAKE}  ${TARGET_PKGS}
	${MAKE}  ${DEPS}/img-runtime

##########################################################################
##
##    依存関係。
##

${DEPS}/initialized :
	mkdir -p ${DEPS}
	touch ${DEPS}/initialized

${DEPS}/img-basepkg : ${DEPS}/initialized Dockerfile
	${MAKE}  build-basepkg
	if ${CHKIMG} ${PACKAGE_NAME}-basepkg ; then  \
	    touch ${DEPS}/img-basepkg;  \
	fi

${DEPS}/img-builder : ${DEPS}/img-basepkg Dockerfile
	${MAKE}  build-builder
	if ${CHKIMG} ${PACKAGE_NAME}-builder ; then  \
	    touch ${DEPS}/img-builder;  \
	fi

${TARGET_PKGS}      : ${DEPS}/img-builder
	${MAKE}  clean-container
	${MAKE}  compile-pbspro

${DEPS}/img-runtime : ${TARGET_PKGS}
	${MAKE}  build-runtime
	if ${CHKIMG} ${PACKAGE_NAME}-runtime ; then  \
	    touch ${DEPS}/img-runtime;  \
	fi

##########################################################################
##
##    ビルドターゲット。
##

update-deps     :
	if ! ${CHKIMG} ${PACKAGE_NAME}-basepkg ; then  \
	    rm -f ${DEPS}/img-basepkg;  \
	fi
	if ! ${CHKIMG} ${PACKAGE_NAME}-builder ; then  \
	    rm -f ${DEPS}/img-basepkg;  \
	fi

build-basepkg   :
	${DOCKER_CMD} build     \
	    --target basepkg    \
	    --tag ${PACKAGE_NAME}-basepkg   \
	    ${SOURCE_DIR}

build-builder   :
	${DOCKER_CMD} build     \
	    --target builder    \
	    --tag ${PACKAGE_NAME}-builder   \
	    ${SOURCE_DIR}

compile-pbspro  :
	${COMPILE_PBS} ${PACKAGE_NAME}-builder ${TARGET_PKGS}

build-runtime   :
	${INSTALL_PBS} ${PACKAGE_NAME}-runtime

##########################################################################
##
##    クリーンターゲット。
##

clean-container :
	${DOCKER_CMD} ps -a
	${DOCKER_CMD} rm -f compile-pbspro
	${DOCKER_CMD} ps -a

clean           : clean-runtime

clean-basepkg   :
	if ${CHKIMG} ${PACKAGE_NAME}-basepkg ; then  \
	    ${DOCKER_CMD} rmi ${PACKAGE_NAME}-basepkg ;  \
	fi
	rm -f ${DEPS}/img-basepkg

clean-builder   :
	if ${CHKIMG} ${PACKAGE_NAME}-builder ; then  \
	    ${DOCKER_CMD} rmi ${PACKAGE_NAME}-builder ;  \
	fi
	rm -f ${DEPS}/img-builder

clean-runtime   :
	if ${CHKIMG} ${PACKAGE_NAME}-runtime ; then  \
	    ${DOCKER_CMD} rmi ${PACKAGE_NAME}-runtime ;  \
	fi
	rm -f ${DEPS}/img-runtime

clean-objs      :

clean-all       : clean-runtime clean-builder clean-basepkg clean-objs
