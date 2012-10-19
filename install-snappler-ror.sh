#!/bin/bash

INSTALL_DIR="snappler-ror-sources"
SOURCE_FILE="snappler-ror-sources.tar"
CONFIG_FILE="snappler-ror.conf"

#Si se pone en true, no ejecuta comando que hace que el script tarde mucho, es para hacer preubas
TEST=false

#Instalar LAMP (interesa sobre todo para el MySQL)
if  ! $TEST ; then
  sudo apt-get -y install lamp-server^
fi

#Creo un directorio donde se van a poner los archivos necesarios para la instalación de todo
#Si existe el tar
if [  -f ./$SOURCE_FILE ]; then
  #Descomprimo y pongo todo en un directorio
  mkdir ~/$INSTALL_DIR
  cp ./$SOURCE_FILE ~/$INSTALL_DIR
  cd ~
  cd $INSTALL_DIR 
  tar -xvf $SOURCE_FILE

  #Asignando permisos de ejecucion
  chmod 755 netbeans-6.9.1-ml-ruby-linux.sh
  chmod 755 _snp_rails_debug_patchs.sh
  chmod 755 _snp_rails_gemset.sh
  chmod 755 _snp_rails_netbeans_script.sh
  chmod 755 _snp_rails_debug_gems.sh
  chmod 755 _snp_rails_gemset_nifty_custom.sh
   
  
  #Crear el directorio que tiene las versiones de rails y ruby, y el archivo de template
  sudo mkdir /etc/snappler_ror
  sudo cp $CONFIG_FILE /etc/snappler_ror
  source /etc/snappler_ror/$CONFIG_FILE
  
  sudo cp $TEMPLATE_FILE /etc/snappler_ror
  sudo chmod 644 /etc/snappler_ror/$TEMPLATE_FILE
  
  sudo cp $RUBY_DEBUG_PATCH_FILE /etc/snappler_ror
  sudo chmod 644 /etc/snappler_ror/$RUBY_DEBUG_PATCH_FILE

  sudo cp $XML_PRINTER_PATCH_FILE /etc/snappler_ror
  sudo chmod 644 /etc/snappler_ror/$XML_PRINTER_PATCH_FILE

  sudo cp _snp_rails* /etc/snappler_ror
  sudo chmod 755 /etc/snappler_ror/_snp_rails*

  sudo cp $XML_PRINTER_PATCH_FILE /etc/snappler_ror
  sudo chmod 644 /etc/snappler_ror/$XML_PRINTER_PATCH_FILE

  sudo cp $MIGRATE_EASY_FILE /etc/snappler_ror
  sudo chmod 644 /etc/snappler_ror/$MIGRATE_EASY_FILE

  sudo cp $MODEL_USER_FILE /etc/snappler_ror
  sudo chmod 644 /etc/snappler_ror/$MODEL_USER_FILE

  sudo cp -R devise /etc/snappler_ror/
  sudo chmod -R 755 /etc/snappler_ror/devise

  sudo cp -R generators /etc/snappler_ror/
  sudo chmod -R 755 /etc/snappler_ror/generators

  sudo cp -R images /etc/snappler_ror/
  sudo chmod -R 755 /etc/snappler_ror/images

  
  #Imagenes para rails
  sudo mkdir /etc/snappler_ror/rails_index_page
  sudo cp rails.png /etc/snappler_ror/rails_index_page
  sudo cp index.html /etc/snappler_ror/rails_index_page
  
  sudo mv ruby-debug-gems /etc/snappler_ror/ 
  sudo chmod 755 /etc/snappler_ror/ruby-debug-gems/
  sudo chmod -R 644 /etc/snappler_ror/ruby-debug-gems/*
  sudo chown -R root:root /etc/snappler_ror/ruby-debug-gems

  #Instalar RVM
  if [ ! -d ~/.rvm ]; then  #solo instala si no está
    sudo apt-get -y install curl
    curl -L https://get.rvm.io | bash -s stable

    #Configuración de RVM
    if [  -f ~/.bash_profile ]; then
      LINE=`tail -1 ~/.bashrc`
        if [ ! "$LINE" == "source ~/.bash_profile" ]; then
          echo -e "\n" >> ~/.bashrc
          echo "#Agregado por JLB para que funcione RVM" >> ~/.bashrc
          echo "source ~/.bash_profile" >> ~/.bashrc
        fi
    fi
  
    #Instalar dependencias de RVM
    sudo apt-get -y install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion
  
    #Cargar RVM
    source ~/.bash_profile

    #Instalar ree
    rvm install $SNP_RUBY_VERSION  
  fi
  
  #Script para nuevo proyecto rails a /usr/bin
  sudo cp ~/$INSTALL_DIR/snp_rails.sh /usr/bin/snp_rails
  sudo chmod 755 /usr/bin/snp_rails

  #Script para agregar debug a proyecto rails a /usr/bin
  sudo cp ~/$INSTALL_DIR/snp_rails_add_debug.sh /usr/bin/snp_rails_add_debug
  sudo chmod 755 /usr/bin/snp_rails_add_debug


  #Gmate para Gedit
  if  ! $TEST ; then
    sudo apt-add-repository ppa:ubuntu-on-rails/ppa
    sudo apt-get update
    sudo apt-get -y install gedit-gmate
  fi
  
  ############################# Paquetes para que funcione rails 3.1.6
  
  #Error
  #Durante: bundle install
  #Mensaje: Installing mysql2 (0.3.11) with native extensions 
  #         Gem::Installer::ExtensionBuildError: ERROR: Failed to build gem native extension.
  if  ! $TEST ; then
    sudo apt-get -y install mysql-client libmysqlclient-dev
  fi
  
  
  ############################ Preparando variables de entorno para RoR y Netbeans
  if  ! $TEST ; then
    [ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"
    rvm use $SNP_RUBY_VERSION
    GEM_HOME_TEMP=$GEM_HOME
  
    ln -s $GEM_HOME@global $HOME/.rvm/netbeans-gems
  fi

  ############################ Netbeans
  #OpenJDK 6 para Netbeans 6.9.1
  if  ! $TEST ; then
    sudo apt-get -y install openjdk-6-jdk
    cd ~
    cd $INSTALL_DIR
    chmod 755 netbeans-6.9.1-ml-ruby-linux.sh
    ./netbeans-6.9.1-ml-ruby-linux.sh
  fi
  #Quitar glashfish
  #Aceptar contrato
  #poner punto (.) al directorio para que esté oculto
  #Quitar los dos tildes
  
  
  #Eliminando recursos
  cd ~
  cd $INSTALL_DIR
  sudo rm -R *
  cd ..
  rmdir $INSTALL_DIR
  
  
  #Instrucciones para Netbeans
  rvm use $SNP_RUBY_VERSION
  
  echo -e "\n\n\n\nIMPORTANTE: Configuración de Netbeans"
  echo -e "Abrir Netbeans 6.9.1 YA."
  echo -e "Ir a:\n"
  echo -e "  Tools - Ruby Platforms\n"
  echo -e "Seleccionar Plataforma:\n"
  echo -e "  * Ruby 1.9.3\n"
  echo -e "Gem Home:"
  echo -e "  * /home/$USER/.rvm/netbeans-gems\n"
  echo -e "Gem Path, dejar SOLO:\n"
  echo -e "  * $GEM_HOME@global\n"
 
else
  echo -e "No está el archivo $SOURCE_FILE "
fi






