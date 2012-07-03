#!/bin/bash

PACKAGE_DIR="snappler-ror-install"
SOURCE_FILE="snappler-ror-sources.tar"
INSTALL_FILE="install-snappler-ror.sh"

if [  -f ~/$PACKAGE_DIR/$SOURCE_FILE ]; then
  rm ~/$PACKAGE_DIR/$SOURCE_FILE
fi

if [  -f ~/$PACKAGE_DIR/$INSTALL_FILE ]; then
  rm ~/$PACKAGE_DIR/$INSTALL_FILE
fi

if [ ! -d ~/$PACKAGE_DIR ]; then
  mkdir ~/$PACKAGE_DIR
fi

#Si no esta el instaladore de netbeans, lo baja
if [ ! -f ./netbeans-6.9.1-ml-ruby-linux.sh ]; then
  wget http://download.netbeans.org/netbeans/6.9.1/final/bundles/netbeans-6.9.1-ml-ruby-linux.sh
fi

tar -cvf ~/$PACKAGE_DIR/$SOURCE_FILE snp_rails.sh snappler-ror.conf rails_template_device.rb netbeans-6.9.1-ml-ruby-linux.sh ruby-debug-ide-patch.rb ruby-debug-gems rails.png index.html
sudo chmod 644 ~/$PACKAGE_DIR/$SOURCE_FILE
cp ./$INSTALL_FILE ~/$PACKAGE_DIR/
sudo chmod 755 ~/$PACKAGE_DIR/$INSTALL_FILE
