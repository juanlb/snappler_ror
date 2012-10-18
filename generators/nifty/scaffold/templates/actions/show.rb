    def show
      @<%= instance_name %> = <%= class_name %>.find(params[:id])
      @breadcrumbs = [["#{t(:<%= instances_name %>).capitalize}", "/<%= instances_name %>"],["Ver", "/<%= instances_name %>/#{params[:id]}"]]
    end
