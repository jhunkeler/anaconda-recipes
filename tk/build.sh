#!/bin/bash

VER=$PKG_VERSION

curl -L -o tcl${VER}.tar.gz "http://sourceforge.net/projects/tcl/files/Tcl/${VER}/tcl${VER}-src.tar.gz/download"
curl -L -o tk${VER}.tar.gz "http://sourceforge.net/projects/tcl/files/Tcl/${VER}/tk${VER}-src.tar.gz/download"

tar xzf tcl${VER}.tar.gz
tar xzf tk${VER}.tar.gz

pushd tcl${VER}/unix
./configure --prefix=$PREFIX
make
make install
popd

OPTS='--enable-threads'

if [ `uname` == Darwin ]; then
    OPTS+=' --enable-aqua=yes'
fi

if [[ $ARCH > 32 ]]; then
	OPTS+=' --enable-64-bit'
fi

pushd tk${VER}/unix
./configure --with-tcl=$PREFIX/lib $OPTS --prefix=$PREFIX
make
make install
popd

cd $PREFIX
rm -rf man share
