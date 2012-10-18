    def block_action
      if(params[:<%= instances_name %>])
        case params[:action_method]
        when 'destroy'
          <%= instances_name %> = <%= class_name %>.find(params[:<%= instances_name %>])
          <%= instances_name %>_size = <%= instances_name %>.size
          <%= instances_name %>.each{|x| x.destroy}
          flash[:notice] = "#{<%= instances_name %>_size} #{t(:<%= instances_name %>).capitalize} borrados correctamente."
          redirect_to <%= instances_name %>_url
        end
      else
        flash[:warning] = "No selecciono #{t(:<%= instances_name %>).capitalize}."
        redirect_to <%= instances_name %>_url
      end
    end

