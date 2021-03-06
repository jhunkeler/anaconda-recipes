#!/bin/bash

ARCH="$(uname 2>/dev/null)"

export CFLAGS="-pipe -O2 -fPIC -I${PREFIX}/include"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS="-L${PREFIX}/lib"

if [ `uname` == Darwin ]; then
    export DYLD_FALLBACK_LIBRARY_PATH=$PREFIX/lib
else
    export LD_LIBRARY_PATH=$PREFIX/lib
fi

chmod +x configure

#    --enable-linux-lfs \

./configure \
    --disable-static \
    --with-ssl \
    --with-zlib \
    --disable-netcdf \
    --disable-fortran \
    --prefix=$PREFIX

make
make install
