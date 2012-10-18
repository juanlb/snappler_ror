#!/bin/bash

CONFIG_FILE="snappler-ror.conf"
source /etc/snappler_ror/$CONFIG_FILE

  export RVM_SRC=$1
  gem install /etc/snappler_ror/ruby-debug-gems/ruby_core_source-0.1.5.gem -- --with-ruby-include=/$RVM_SRC
  gem install /etc/snappler_ror/ruby-debug-gems/linecache19-0.5.13.gem -- --with-ruby-include=/$RVM_SRC
  gem install /etc/snappler_ror/ruby-debug-gems/ruby-debug-base19-0.11.26.gem -- --with-ruby-include=/$RVM_SRC
  gem install /etc/snappler_ror/ruby-debug-gems/ruby-debug19-0.11.6.gem -- --with-ruby-include=/$RVM_SRC  
