#!/bin/bash

CONFIG_FILE="snappler-ror.conf"
source /etc/snappler_ror/$CONFIG_FILE


  cd $1


  #Agrego cosas al Gemfile
  LINEA="gem 'ruby-debug-ide', '0.4.16'"
  if ! grep  "$LINEA" ./Gemfile > /dev/null
  then
    echo -e "\n#Para que no falle el rake\ngem 'therubyracer', '~> 0.9.9'"  >> Gemfile
    echo -e "\n#Para poder debuggear rails desde Netbeans\ngem 'ruby-debug-ide', '0.4.16'"  >> Gemfile
    echo -e "gem 'debugger', '1.1.4'" >> Gemfile
    echo -e "gem 'archive-tar-minitar', '0.5.2'" >> Gemfile
  fi

echo -e "source 'https://rubygems.org'" >> Gemfile

