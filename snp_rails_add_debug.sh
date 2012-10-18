#!/bin/bash

CONFIG_FILE="snappler-ror.conf"
source /etc/snappler_ror/$CONFIG_FILE

if [ -f ./.rvmrc ]; then
  #cargar rvm
  [ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"  

  #Tomo la version de ruby y gemset
  RVM_RUBY_GEMSET=`tail -1 ./.rvmrc`

  #Cargo RVM
  $RVM_RUBY_GEMSET

  #Modificar el Gemset para debugger
  PATH_INSTALACION=`pwd`
  /etc/snappler_ror/_snp_rails_gemset.sh $PATH_INSTALACION

  cd $PATH_INSTALACION

  bundle install
  
  #Instalando Gems locales para debugger
  RVM_SRC_DIR=$(ls -dm ~/.rvm/src/ruby-1.9.3*/)
  /etc/snappler_ror/_snp_rails_debug_gems.sh $RVM_SRC_DIR 

  #Armar el script para cambiar de gemset en Netbeans
  /etc/snappler_ror/_snp_rails_netbeans_script.sh $PATH_INSTALACION $GEM_HOME

  #Aplico patchs
  /etc/snappler_ror/_snp_rails_debug_patchs.sh $PATH_INSTALACION

else
  echo -e "\n\nEl proyecto tiene que tener archivo .rvmrc\n\n"
fi
