#!/bin/bash

CONFIG_FILE="snappler-ror.conf"
source /etc/snappler_ror/$CONFIG_FILE

if [ "$#" != "1" ]; then
  echo -e "\nUso del script:\t$0 nombre-proyecto\n"
  exit 1
else
  echo -e "\nEsto puede tardar un ratito, asi que acomodate...\n\n"

  #cargar rvm
  [ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"

  #Usar el ruby instalado
  rvm use $SNP_RUBY_VERSION
  
  #Crear el Gemset
  rvm gemset create $1-gemset

  #Usar ruby-gemset
  rvm use $SNP_RUBY_VERSION@$1-gemset

  #Instalar la version de ruby
  gem install rails -v $SNP_RAILS_VERSION

  #Crear el proyecto
  rails new $1 --database=mysql

  #Crear el .rvmrc
  echo "rvm $SNP_RUBY_VERSION@$1-gemset" > ./$1/.rvmrc

  #Modificar el Gemset
  cd $1
  echo -e "\n#Para que no falle el rake\ngem 'therubyracer', '~> 0.9.9'"  >> Gemfile
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
  
  #Agregar index.html con imagen de snappminds
  sudo cp /etc/snappler_ror/rails_index_page/index.html ./public
  sudo cp /etc/snappler_ror/rails_index_page/rails.png ./app/assets/images
  sudo chown $USER:$USER ./public/index.html
  sudo chown $USER:$USER ./app/assets/images/rails.png
  
  #Cambiar la pass del config/database.yml
  db_user=$1"_user"
  db_pass=$1"_pass"
  sed s/root/$db_user/ config/database.yml > config/database_temp.yml
  sed s/password:/password:\ $db_pass/ config/database_temp.yml > config/database.yml
  rm config/database_temp.yml
  
  
  db_prod=$1"_production"
  db_test=$1"_test"
  db_dev=$1"_development"
  echo -e "CREATE DATABASE $db_prod; GRANT ALL PRIVILEGES ON $db_prod.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass' WITH GRANT OPTION;\n"  > config/creacion_bases.sql
  echo -e "CREATE DATABASE $db_test; GRANT ALL PRIVILEGES ON $db_test.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass' WITH GRANT OPTION;\n"  >> config/creacion_bases.sql
  echo -e "CREATE DATABASE $db_dev; GRANT ALL PRIVILEGES ON $db_dev.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass' WITH GRANT OPTION;\n"  >> config/creacion_bases.sql

  echo -e "\n\nIngrese el Password de root de MySQL\n"
  mysql -u root -p < config/creacion_bases.sql
  
  echo -e "Debe ejecutar:\n\n    cd $1\n    bundle install\n    rake db:migrate:all"
  echo -e "\n\nSi desea devise:\n\n    rake rails:template LOCATION=/etc/snappler_ror/$TEMPLATE_FILE\n    rake db:migrate"

fi
