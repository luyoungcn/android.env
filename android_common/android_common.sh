#!/bin/bash

source common.sh

function android_build_toolchain()
{
    msg "MODULE: android_common FUNC: ${FUNCNAME[0]}"

	sudo apt-get -y install git gnupg flex bison gperf build-essential \
zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
libx11-dev:i386 libreadline6-dev:i386 libglapi-mesa:i386 libgl1-mesa-glx:i386 \
libgl1-mesa-dev g++-multilib mingw32 tofrodos \
python-markdown libxml2-utils xsltproc zlib1g-dev:i386

	sudo apt-get -y install ubuntu-desktop xorg

    sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so
}

function android_build_java()
{
    msg "MODULE: android_common FUNC: ${FUNCNAME[0]}"

    icedtea="icedtea-7-plugin_1.2.3-0ubuntu0.12.04.4_amd64.deb"
    f_icedtea=$APP_PATH/android_common/$icedtea

    sudo apt-get -y install openjdk-7-jdk

    sudo dpkg -i $f_icedtea

    if [ $? -ne 0 ]
    then
    sudo apt-get -y -f install
    fi

    sudo update-java-alternatives -s java-1.7.0-openjdk-amd64

     msg `java -version`
}

function android_adb()
{
    msg "MODULE: android_common FUNC: ${FUNCNAME[0]}"

    adb="adb"
    f_adb=$APP_PATH/android_common/$adb

    adb_usb="adb_usb.ini"
    f_adb_usb=$APP_PATH/android_common/$adb_usb

    adb_udev_rules="88-android.rules"
    f_adb_udev_rules=$APP_PATH/android_common/$adb_udev_rules

    sudo cp $f_adb /usr/bin/

    mkdir -p ~/.android
    cp $f_adb_usb ~/.android/

    sudo cp $f_adb_udev_rules /etc/udev/rules.d/
}

function android_fastboot()
{
    msg "MODULE: android_common FUNC: ${FUNCNAME[0]}"

    fastboot="fastboot"
    f_fastboot=$APP_PATH/android_common/$fastboot

    sudo cp $f_fastboot /usr/bin/
}
