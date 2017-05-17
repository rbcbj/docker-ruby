#!/bin/bash

RUBY_MAJOR="2.2"
RUBY_VERSION="2.2.2"
RUBY_DOWNLOAD_SHA256="f033b5d08ab57083e48c1d81bcd7399967578c370b664da90e12a32891424462"

cd /tmp/ruby-2.2.2

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

rm -rfv /tmp/ruby-2.2.2
rm /tmp/ruby-2.2.2.sh