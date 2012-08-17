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
  echo -e "\n#Para poder debuggear rails desde Netbeans\ngem 'ruby-debug-ide', '~> 0.4.16'"  >> Gemfile
  echo -e "gem 'debugger', '~> 1.1.4'" >> Gemfile
  echo -e "gem 'archive-tar-minitar', '~> 0.5.2'" >> Gemfile

  bundle install
  
  #Instalando Gems locales para debugger
  RVM_SRC_DIR=$(ls -dm ~/.rvm/src/ruby-1.9.3*/)
  export RVM_SRC=$RVM_SRC_DIR
  gem install /etc/snappler_ror/ruby-debug-gems/ruby_core_source-0.1.5.gem -- --with-ruby-include=/$RVM_SRC
  gem install /etc/snappler_ror/ruby-debug-gems/linecache19-0.5.13.gem -- --with-ruby-include=/$RVM_SRC
  gem install /etc/snappler_ror/ruby-debug-gems/ruby-debug-base19-0.11.26.gem -- --with-ruby-include=/$RVM_SRC
  gem install /etc/snappler_ror/ruby-debug-gems/ruby-debug19-0.11.6.gem -- --with-ruby-include=/$RVM_SRC   

  #Armar el script para cambiar de gemset en Netbeans
  echo -e "#!/bin/bash" > set_netbeans-gems.sh
  echo -e "if [ -d ~/.rvm/netbeans-gems ]; then" >> set_netbeans-gems.sh
  echo -e " rm ~/.rvm/netbeans-gems" >> set_netbeans-gems.sh
  echo -e "fi" >> set_netbeans-gems.sh
  echo -e "ln -s $GEM_HOME ~/.rvm/netbeans-gems" >> set_netbeans-gems.sh
  chmod 755 set_netbeans-gems.sh

  #Poner el path del debugger
  sudo cp /etc/snappler_ror/$RUBY_DEBUG_PATCH_FILE $GEM_HOME/gems/ruby-debug-ide-0.4.16/lib/ruby-debug-ide.rb
  sudo chown $USER:$USER $GEM_HOME/gems/ruby-debug-ide-0.4.16/lib/ruby-debug-ide.rb

  sudo cp /etc/snappler_ror/$XML_PRINTER_PATCH_FILE $GEM_HOME/gems/ruby-debug-ide-0.4.16/lib/ruby-debug/xml_printer.rb
  sudo chown $USER:$USER $GEM_HOME/gems/ruby-debug-ide-0.4.16/lib/ruby-debug/xml_printer.rb

else
  echo -e "\n\nEl proyecto tiene que tener archivo .rvmrc\n\n"
fi
