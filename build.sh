#!/bin/bash

TOKEN=$1

sudo apt-get install -y build-essential checkinstall cmake pkg-config yasm git gfortran libjpeg8-dev
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu> xenial-security main" && sudo apt update -y
sudo apt-get install libjasper1 libjasper-dev libpng-dev libtiff5-dev libavcodec-dev libavformat-dev libswscale-dev libxine2-dev libv4l-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev qt5-default libgtk2.0-dev libtbb-dev libatlas-base-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libopencore-amrnb-dev libopencore-amrwb-dev x264 v4l-utils -y



sudo apt-get -y install python3-dev python3-pip
sudo -H pip3 install -U pip numpy && sudo pip3 install virtualenv virtualenvwrapper


echo "# Virtual Environment Wrapper" >> ~/.bashrc echo "export
VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc

git clone https://$TOKEN@github.com/militech-at/opencv.git

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout 3.3.1
cd ..

cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D WITH_TBB=ON \
-D WITH_V4L=ON \
-D WITH_QT=ON \
-D WITH_OPENGL=ON \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
-D BUILD_EXAMPLES=ON ..


make -j$(nproc)
sudo make install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
cd ..

sudo apt -y install libeigen3-dev 
sudo apt-get -y install libblas-dev liblapack-dev libboost-all-dev


git clone https://$TOKEN@github.com/militech-at/Pangolin.git
sudo apt -y install libgl1-mesa-dev libglew-dev cmake
cd Pangolin
mkdir build
cd build
cmake ..
cmake --build .
make
sudo make install
cd ..



pip3 install -y matplotlib open3d==12.0.0 pyntcloud


git clone https://$TOKEN@github.com/militech-at/Autonomous-Drone-Scanning-and-Mapping
git clone https://$TOKEN@github.com/militech-at/ORB_SLAM2

cd ORB_SLAM2
./build.sh
cd ..

git clone https://$TOKEN@github.com/militech-at/ORB_SLAM3

cd ORB_SLAM3
./build.sh
cd ..
