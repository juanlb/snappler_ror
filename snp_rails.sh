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

  #Estas gemas las pide en la maquina de JLB, pero puede ser por problemas de configuracion
  #gem install archive-tar-minitar -v 0.5.2
  #gem install columnize -v 0.3.6
  #gem install debugger-ruby_core_source - v1.1.3
  #gem install debugger-linecache -v 1.1.2
  #gem install debugger -v 1.1.4
  #gem install ruby-debug-ide -v 0.4.16


  #Crear el proyecto
  rails new $1 --database=mysql

  #Crear el .rvmrc
  echo "rvm $SNP_RUBY_VERSION@$1-gemset" > ./$1/.rvmrc

  #Path de instalacion
  PATH_INSTALACION=`pwd`

  #Modificar el Gemset para debug
  /etc/snappler_ror/_snp_rails_gemset.sh $PATH_INSTALACION/$1

  #Modificar el Gemset para nifty custom
  /etc/snappler_ror/_snp_rails_gemset_nifty_custom.sh $PATH_INSTALACION/$1

  cd $1


  bundle install

  #Para nifty
  RAKE_SRC_DIR=$(ls -dm ~/.rvm/gems/ruby-1.9.3*global*)
  RAKE_SRC_DIR=$RAKE_SRC_DIR/bin/rake

  $RAKE_SRC_DIR rails:template LOCATION=/etc/snappler_ror/rails_template_device.rb
  bundle install


  #Easy roles
  rails g migration add_easy_roles_to_users
  #Modifico la migracion
  MIGRATION_FILE=$(ls -dm db/migrate/*easy*)

  sudo cp /etc/snappler_ror/$MIGRATE_EASY_FILE $MIGRATION_FILE
  sudo chown $USER:$USER $MIGRATION_FILE

  sudo cp /etc/snappler_ror/$MODEL_USER_FILE app/models/user.rb
  sudo chown $USER:$USER app/models/user.rb
  
  #Instalando Gems locales para debugger
  RVM_SRC_DIR=$(ls -dm ~/.rvm/src/ruby-1.9.3*/)
  /etc/snappler_ror/_snp_rails_debug_gems.sh $RVM_SRC_DIR


  #Armar el script para cambiar de gemset en Netbeans
  /etc/snappler_ror/_snp_rails_netbeans_script.sh $PATH_INSTALACION/$1 $GEM_HOME

  #Aplico patchs
  /etc/snappler_ror/_snp_rails_debug_patchs.sh $PATH_INSTALACION/$1

  #Agrego los directorios para nifty custom
  sudo cp -R /etc/snappler_ror/generators lib/
  sudo chown -R $USER:$USER lib/

  sudo cp -R /etc/snappler_ror/devise app/views
  sudo chown -R $USER:$USER app/views

  sudo cp -R /etc/snappler_ror/images app/assets/
  sudo chown -R $USER:$USER app/assets

  
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
  
  #Modificar archivos de la aplicacion para que funcione con nifty
  LINEA="ActionView::Base.field_error_proc"
  if ! grep  "$LINEA" config/environment.rb > /dev/null
  then
    sed -i "s0__FILE__)0__FILE__)\n\n#Para dibujar los errores en los formularios de otra forma\nActionView::Base.field_error_proc = Proc.new {|html_tag, instance|\n \"<span class='error-field'>#{html_tag}</span>\".html_safe}0g" config/environment.rb
  fi

  LINEA="gem 'config.autoload_paths += %W(#{config.root}/lib)"
  if ! grep  "$LINEA" config/application.rb > /dev/null
  then
    sed -i "s0  end0\n    #Configuracion de internalizacion por defecto en Español\n    config.i18n.default_locale = :en\n\n    #Para q cargue bien las cosas de lib\n    config.autoload_paths += %W(#{config.root}/lib)\n  end0g" config/application.rb
  fi

  #Instalar los layouts de nifty
  echo ""
  echo ""
  echo ""
  echo ""
  echo "                          Instalando los layouts de Nifty Scaffolds"
  echo "                          Dale a todos que YES"
  echo ""
  echo ""
  echo ""
  echo ""

  rails g nifty:layout 


  db_prod=$1"_production"
  db_test=$1"_test"
  db_dev=$1"_development"
  echo -e "CREATE DATABASE $db_prod; GRANT ALL PRIVILEGES ON $db_prod.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass' WITH GRANT OPTION;\n"  > config/creacion_bases.sql
  echo -e "CREATE DATABASE $db_test; GRANT ALL PRIVILEGES ON $db_test.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass' WITH GRANT OPTION;\n"  >> config/creacion_bases.sql
  echo -e "CREATE DATABASE $db_dev; GRANT ALL PRIVILEGES ON $db_dev.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass' WITH GRANT OPTION;\n"  >> config/creacion_bases.sql

  echo -e "\n\nIngrese el Password de root de MySQL\n"
  mysql -u root -p < config/creacion_bases.sql
  
  echo -e "Debe ejecutar:\n\n    cd $1\n    bundle install\n    rake db:migrate:all"
  echo -e "\nPara usar los scaffolds magicos, se empieza asi:"
  echo -e "\n\n    rails g nifty:scaffold {nombre modelo} {campo:tipo EJ: name:string color:string age:text life:boolean}"


fi
