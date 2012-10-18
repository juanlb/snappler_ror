#!/bin/bash

CONFIG_FILE="snappler-ror.conf"
source /etc/snappler_ror/$CONFIG_FILE

  #Poner el patch del debugger
  sudo cp /etc/snappler_ror/$RUBY_DEBUG_PATCH_FILE $GEM_HOME/gems/ruby-debug-ide-0.4.16/lib/ruby-debug-ide.rb
  sudo chown $USER:$USER $GEM_HOME/gems/ruby-debug-ide-0.4.16/lib/ruby-debug-ide.rb

  sudo cp /etc/snappler_ror/$XML_PRINTER_PATCH_FILE $GEM_HOME/gems/ruby-debug-ide-0.4.16/lib/ruby-debug/xml_printer.rb
  sudo chown $USER:$USER $GEM_HOME/gems/ruby-debug-ide-0.4.16/lib/ruby-debug/xml_printer.rb
