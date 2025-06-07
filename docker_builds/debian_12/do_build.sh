#!/bin/bash
set -e
cd /root

# Install dependencies and tools
apt-get update
apt-get install -y libcurl4-openssl-dev libglfw3-dev libfftw3-dev libvolk-dev build-essential cmake pkgconf \
    libjpeg-dev libpng-dev libtiff-dev libairspy-dev libairspyhf-dev libhackrf-dev librtlsdr-dev libomp-dev \
    libnng-dev libiio-dev libzstd-dev libad9361-dev libbladerf-dev libuhd-dev liblimesuite-dev ocl-icd-opencl-dev \
    libjemalloc-dev portaudio19-dev libhdf5-dev p7zip-full wget cmake

# Install SDRPlay libraries
BUILD_ARCH=$(dpkg --print-architecture)
wget https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.15.2.run
7z x ./SDRplay_RSP_API-Linux-3.15.2.run
7z x ./SDRplay_RSP_API-Linux-3.15.2
cp $BUILD_ARCH/libsdrplay_api.so.3.15 /usr/lib/libsdrplay_api.so
cp inc/* /usr/include/

cd SatDump
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
make -j`nproc`

sh ../make_deb_package.sh ./build $BUILD_ARCH 'libc6, libgcc-s1, libstdc++6, libfftw3-bin, libglfw3, libjemalloc2, libnng1, libomp5-14, libopengl0, libpng16-16, libtiff6, libvolk2.5, libzstd1, libhdf5-103' 'libportaudiocpp0, libad9361-0, libairspy0, libairspyhf1, libbladerf2, libhackrf0, liblimesuite22.09-1, librtlsdr0, libuhd4.3.0, uhd-host, ocl-icd-libopencl1, zenity, libiio0'