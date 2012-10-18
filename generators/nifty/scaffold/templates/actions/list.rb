    def list
      ord = setOrderQuery("<%= model_attributes.first.name %>", params[:ord], params[:sen])
      @page = (params[:page])? params[:page] : 1 ;
      @epp = (params[:epp])? params[:epp] : 5 ;

      @<%= instances_name %> = <%= class_name %>.paginate(:page => @page, :per_page => @epp, :order => ord)

      render :layout => false
    end
