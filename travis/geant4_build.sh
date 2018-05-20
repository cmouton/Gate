# Parameter:
# version: Geant4 version to be downloaded, compiled and installed.
# Warning : only the version "10.00.p02", "10.01" and "10.01.p01" have been tested with this script.
# Example:
# /bin/bash geant4_build.sh 10.01

cd $HOME
rm -rf geant4.$1
mkdir geant4.$1
cd geant4.$1/
mkdir geant4.$1-build
mkdir geant4.$1-install

# Retrieve the source.
#wget http://geant4.web.cern.ch/geant4/support/source/geant4.$1.tar.gz
wget http://cern.ch/geant4-data/releases/geant4.10.03.p03.tar.gz
tar xvzf geant4.$1.tar.gz

# Build.
cd geant4.$1-build/
cmake -DCMAKE_INSTALL_PREFIX:PATH=$HOME/geant4.$1/geant4.$1-install/ \
      -DGEANT4_INSTALL_DATA:BOOL=ON ../geant4.$1 \
# Trick added to be compatible with the free version of Travis (<10 min without output, max output size 4MB, <30 min)
      > $HOME/geant4.$1/geant4_install_log.txt
# Trick added to be compatible with the free version of Travis
ls
make -j8
# Trick added to be compatible with the free version of Travis
>> $HOME/geant4.$1/geant4_install_log.txt

# Install.
make install \
# Trick added to be compatible with the free version of Travis
>> $HOME/geant4.$1/geant4_install_log.txt

source $HOME/geant4.$1/geant4.$1-install/bin/geant4.sh
