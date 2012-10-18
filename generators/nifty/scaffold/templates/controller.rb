module <%= module_name_camel %>
  class <%= plural_class_name %>Controller < ApplicationController
    #Descomentar para que se necesite autentificarse para usar el controlador
    #before_filter :authenticate_user!

    #En caso de querer que en alguna 'action' no necesite autentificarse 
    #before_filter :authenticate_user!, :except => [:index, :list]

    #Si ademas queres que solo entren usuarios de cierto rol
    #before_filter :user_required_admin_one, :except => [:index, :list]

    <%= controller_methods :actions %>
  end
end
