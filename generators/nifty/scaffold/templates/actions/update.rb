    def update
      @<%= instance_name %> = <%= class_name %>.find(params[:id])
      if @<%= instance_name %>.update_attributes(params[:<%= instance_name %>])
        flash[:notice] = "#{t(:<%= instance_name %>).capitalize} editado correctamente."
        redirect_to <%= item_url %>
      else
        @breadcrumbs = [["#{t(:<%= instances_name %>).capitalize}", "/<%= instances_name %>"],["Editar", "/<%= instances_name %>/#{params[:id]}/edit"]]
        render :edit
      end
    end
