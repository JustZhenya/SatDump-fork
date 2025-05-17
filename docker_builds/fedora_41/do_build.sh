#!/bin/bash
set -e
cd /root

# Install dependencies and tools
# TODO missing: libairspyhf-dev libairspy-dev libad9361-dev libbladerf-dev liblimesuite-dev
dnf install -x mesa-va-drivers -x mesa-va-drivers -y cmake gcc g++ git p7zip p7zip-plugins wget xxd libtool autoconf rpmdevtools pkgconf \
    fftw-devel glfw-devel volk-devel libzstd-devel libiio-devel libcorrect-devel \
    hackrf-devel rtl-sdr-devel portaudio-devel \
    libpng-devel curl-devel libjpeg-devel libtiff-devel jemalloc-devel hdf5-devel uhd-devel nng-devel ocl-icd-devel libomp-devel boost-devel

# Install SDRPlay libraries
wget https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.15.1.run
7z x ./SDRplay_RSP_API-Linux-3.15.1.run
7z x ./SDRplay_RSP_API-Linux-3.15.1
cp x86_64/libsdrplay_api.so.3.15 /usr/lib/libsdrplay_api.so
cp inc/* /usr/include/

cd SatDump
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j`nproc`

sh ../make_rpm_package.sh