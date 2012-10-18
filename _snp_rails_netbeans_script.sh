#!/bin/bash

CONFIG_FILE="snappler-ror.conf"
source /etc/snappler_ror/$CONFIG_FILE

cd $1

  echo -e "#!/bin/bash" > set_netbeans-gems.sh
  echo -e "if [ -d ~/.rvm/netbeans-gems ]; then" >> set_netbeans-gems.sh
  echo -e " rm ~/.rvm/netbeans-gems" >> set_netbeans-gems.sh
  echo -e "fi" >> set_netbeans-gems.sh
  echo -e "ln -s $2 ~/.rvm/netbeans-gems" >> set_netbeans-gems.sh
  chmod 755 set_netbeans-gems.sh
