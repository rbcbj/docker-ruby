#!/bin/bash

RUBY_MAJOR="2.4"
RUBY_VERSION="2.4.1"
RUBY_DOWNLOAD_SHA256="a330e10d5cb5e53b3a0078326c5731888bb55e32c4abfeb27d9e7f8e5d000250"

cd /tmp/ruby-2.4.1

PKG_CONFIG=/usr/bin/pkg-config ./configure --prefix=/usr \
                                           --sysconfdir=/etc \
                                           --localstatedir=/var \
                                           --sharedstatedir=/var/lib \
                                           --libexecdir=/usr/lib/ruby \
                                           --enable-shared \
                                           --disable-rpath \
                                           --with-dbm-type=gdbm_compat \
                                           --disable-install-doc

make
make install-nodoc

rm -rfv /tmp/ruby-2.4.1
rm /tmp/ruby-2.4.1.sh