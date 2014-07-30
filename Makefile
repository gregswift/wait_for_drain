# Base the name of the software on the spec file
PACKAGE := $(shell basename *.spec .spec)
# Override this arch if the software is arch specific
ARCH = noarch

# Variables for clean build directory tree under repository
BUILDDIR = ./build
SDISTDIR = ${BUILDDIR}/sdist
RPMBUILDDIR = ${BUILDDIR}/rpm-build
RPMDIR = ${BUILDDIR}/rpms

# base rpmbuild command that utilizes the local buildroot
# not using the above variables on purpose.
# if you can make it work, PRs are welcome!
RPMBUILD = rpmbuild --define "_topdir %(pwd)/build" \
	--define "_sourcedir  %{_topdir}/sdist" \
	--define "_builddir %{_topdir}/rpm-build" \
	--define "_srcrpmdir %{_rpmdir}" \
	--define "_rpmdir %{_topdir}/rpms"

INSTALLDIR = bin/

all: rpms

clean:
	rm -rf ${BUILDDIR}/ *~

install: 
	mkdir -p ${DESTDIR}${INSTALLDIR}
	cp -pr . ${DESTDIR}${INSTALLDIR}

install_rpms: rpms 
	yum install ${RPMDIR}/${ARCH}/${PACKAGE}*.${ARCH}.rpm

reinstall: uninstall install

uninstall: clean
	rm -f ${DESTDIR}${INSTALLDIR}

uninstall_rpms: clean
	rpm -e ${PACKAGE}

sdist:
	mkdir -p ${SDISTDIR}
	tar -czf ${SDISTDIR}/${PACKAGE}.tar.gz \
		--exclude ".git" --exclude "*.log" \
		--exclude "Makefile" --exclude "README*" \
		--exclude "*.spec" --exclude "build" \
		./

prep_rpmbuild: sdist
	mkdir -p ${RPMBUILDDIR}
	mkdir -p ${RPMDIR}
	cp ${SDISTDIR}/${PACKAGE}.tar.gz ${RPMBUILDDIR}/

rpms: prep_rpmbuild
	${RPMBUILD} -ba ${PACKAGE}.spec

srpm: prep_rpmbuild
	${RPMBUILD} -bs ${PACKAGE}.spec
