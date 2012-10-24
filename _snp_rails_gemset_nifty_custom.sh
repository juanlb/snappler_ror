#!/bin/bash

CONFIG_FILE="snappler-ror.conf"
source /etc/snappler_ror/$CONFIG_FILE

  cd $1

  #Agrego cosas al Gemfile
  LINEA="gem 'nifty-generators'"
  if ! grep  "$LINEA" ./Gemfile > /dev/null
  then
    echo -e "\n#Para poder debuggear rails desde Netbeans"  >> Gemfile
    echo -e "gem 'nifty-generators'"  >> Gemfile
    echo -e "gem 'mocha'" >> Gemfile

    echo -e "\n#Gema para paginar"  >> Gemfile
    echo -e "gem 'will_paginate'"  >> Gemfile

    echo -e "\n#Gema para agregar devise"  >> Gemfile
    echo -e "gem 'devise'"  >> Gemfile

    echo -e "\n#Gema para agregar roles a devise"  >> Gemfile
    echo -e "gem 'easy_roles'"  >> Gemfile
  fi

