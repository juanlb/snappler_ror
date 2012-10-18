    def edit
      @<%= instance_name %> = <%= class_name %>.find(params[:id])
      @breadcrumbs = [["#{t(:<%= instances_name %>).capitalize}", "/<%= instances_name %>"],["Editar", "/<%= instances_name %>/#{params[:id]}/edit"]]
    end
