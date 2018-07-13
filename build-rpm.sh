#!/bin/bash

for i in ~/rpmbuild/SPECS ~/rpmbuild/SOURCES
do
    [ -d $i ] || {
        echo "$i not exist, try to create it."
        mkdir -p $i
    }
done

tar -zcvf ~/rpmbuild/SOURCES/nova-13.1.4.tar.gz ./nova-13.1.4

for i in *.service nova-* nova.logrotate *.sysconfig
do
    cp -rf $i ~/rpmbuild/SOURCES
done

for i in openstack-nova.spec
do
    cp -rf $i ~/rpmbuild/SPECS
done

pushd ~/rpmbuild/SPECS && {
    rpmbuild -ba openstack-nova.spec
    popd
}
