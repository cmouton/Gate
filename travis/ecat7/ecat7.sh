#!/bin/sh

rm -rf $HOME/ecat7
mkdir $HOME/ecat7
cd $HOME/ecat7
wget www.opengatecollaboration.org/sites/default/files/ecat.tar.gz
tar -xvzf ecat.tar.gz
export ECAT7_DIRECTORY=$HOME/ecat7
cp Makefile.unix Makefile
make
cd utils
# Apply the Makefile patch
cp $SCRIPT_DIRECTORY/ecat7/Makefile .
grep socket Makefile
make
cd ..
mkdir include
cp *.h include/
mkdir lib
cp libecat.a lib/


