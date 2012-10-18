    def create
      @<%= instance_name %> = <%= class_name %>.new(params[:<%= instance_name %>])
      if @<%= instance_name %>.save
        flash[:notice] = "#{t(:<%= instance_name %>).capitalize} creado correctamente."
        redirect_to <%= item_url %>
      else
        @breadcrumbs = [["#{t(:<%= instances_name %>).capitalize}", "/<%= instances_name %>"],["Nuevo", "/<%= instances_name %>/new"]]
        render :new
      end
    end
