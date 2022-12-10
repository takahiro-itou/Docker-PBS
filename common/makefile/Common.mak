##  -*-  coding: utf-8-with-signature-unix; mode: makefile-gmake   -*-  ##

##########################################################################
##
##    フォニーターゲット。
##

.PHONY  :  all  clean-all

all :
	${MAKE}  update-deps
	${MAKE}  ${DEPS}/img-builder

##########################################################################
##
##    依存関係。
##

${DEPS}/initialized :
	mkdir -p ${DEPS}
	touch ${DEPS}/initialized

${DEPS}/img-basepkg : ${DEPS}/initialized Dockerfile
	${MAKE} build-basepkg
	if ${CHKIMG} ${PACKAGE_NAME}-basepkg ; then  \
	    touch ${DEPS}/img-basepkg;  \
	fi

${DEPS}/img-builder : ${DEPS}/img-basepkg Dockerfile
	${MAKE} build-builder
	if ${CHKIMG} ${PACKAGE_NAME}-builder ; then  \
	    touch ${DEPS}/img-builder;  \
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

##########################################################################
##
##    クリーンターゲット。
##
