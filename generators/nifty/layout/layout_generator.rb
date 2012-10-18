require 'generators/nifty'

module Nifty
  module Generators
    class LayoutGenerator < Base
      argument :layout_name, :type => :string, :default => 'application', :banner => 'layout_name'

      class_option :haml, :desc => 'Generate HAML for view, and SASS for stylesheet.', :type => :boolean

      def create_layout
        if options.haml?
          template 'layout.html.haml', "app/views/layouts/#{file_name}.html.haml"
          copy_file 'stylesheet.sass', "public/stylesheets/sass/#{file_name}.sass"
        else
          template 'layout.html.erb', "app/views/layouts/#{file_name}.html.erb"
          copy_file 'css/button.css', "app/assets/stylesheets/button.css"
          copy_file 'css/error.css', "app/assets/stylesheets/error.css"
          copy_file 'css/form.css', "app/assets/stylesheets/form.css"
          copy_file 'css/main.css', "app/assets/stylesheets/main.css"
          copy_file 'css/pagination.css', "app/assets/stylesheets/pagination.css"
          copy_file 'css/table.css', "app/assets/stylesheets/table.css"
          copy_file 'css/jquery-ui.css', "app/assets/stylesheets/jquery-ui.css"
          
          copy_file 'css/submenu-box.css', "app/assets/stylesheets/elements/submenu-box.css"
          copy_file 'css/duallistbox.css', "app/assets/stylesheets/elements/duallistbox.css"
          copy_file 'css/jquery-si.css', "app/assets/stylesheets/elements/jquery-si.css"
          copy_file 'css/rte.css', "app/assets/stylesheets/elements/rte.css"
          copy_file 'css/token-input.css', "app/assets/stylesheets/elements/token-input.css"
          copy_file 'css/token-input-facebook.css', "app/assets/stylesheets/elements/token-input-facebook.css"
          copy_file 'css/token-input-mac.css', "app/assets/stylesheets/elements/token-input-mac.css"

          copy_file 'js/jquery-1-7-1-min.js', "app/assets/javascripts/jquery-1-7-1-min.js"
          copy_file 'js/jquery-ui-1-8-18-min.js', "app/assets/javascripts/jquery-ui-1-8-18-min.js"
          copy_file 'js/table.js', "app/assets/javascripts/table.js"
          copy_file 'js/onload.js', "app/assets/javascripts/onload.js"
          copy_file 'js/ondemand-pagination.js', "app/assets/javascripts/ondemand-pagination.js"
          copy_file 'js/main.js', "app/assets/javascripts/main.js"
          copy_file 'js/rails.js', "app/assets/javascripts/rails.js"
          copy_file 'js/jquery-tokeninput.js', "app/assets/javascripts/jquery-tokeninput.js"
          copy_file 'js/jquery-si.js', "app/assets/javascripts/jquery-si.js"
          copy_file 'js/jquery-rte.js', "app/assets/javascripts/jquery-rte.js"
          copy_file 'js/jquery-ba-bbq.js', "app/assets/javascripts/jquery-ba-bbq.js"
          copy_file 'js/duallistbox.js', "app/assets/javascripts/duallistbox.js"
          copy_file 'js/submenu-box.js', "app/assets/javascripts/submenu-box.js"
          copy_file 'js/custom-functions-ajax.js', "app/assets/javascripts/custom-functions-ajax.js"


        end
        copy_file 'layout_helper.rb', 'app/helpers/layout_helper.rb'
        copy_file 'application_helper.rb', 'app/helpers/application_helper.rb'
        copy_file 'menu_helper.rb', 'app/helpers/menu_helper.rb'
        copy_file 'side_bar_helper.rb', 'app/helpers/side_bar_helper.rb'
        copy_file 'error_messages_helper.rb', 'app/helpers/error_messages_helper.rb'
        copy_file 'application_controller.rb', 'app/controllers/application_controller.rb'
        copy_file 'time_formats.rb', 'config/initializers/time_formats.rb'
        copy_file 'const.rb', 'lib/const.rb'


      end

      private

      def file_name
        layout_name.underscore
      end
    end
  end
end
