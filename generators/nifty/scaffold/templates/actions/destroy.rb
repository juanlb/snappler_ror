    def destroy
      @<%= instance_name %> = <%= class_name %>.find(params[:id])
      @<%= instance_name %>.destroy
      flash[:notice] = "#{t(:<%= instance_name %>).capitalize} borrado correctamente."
      redirect_to <%= items_url %>
    end


