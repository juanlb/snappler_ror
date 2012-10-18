    def new
      @<%= instance_name %> = <%= class_name %>.new
      @breadcrumbs = [["#{t(:<%= instances_name %>).capitalize}", "/<%= instances_name %>"],["Nuevo", "/<%= instances_name %>/new"]]
    end
