    def list
      ord = setOrderQuery("<%= model_attributes.first.name %>", params[:ord], params[:sen])
      @page = (params[:page])? params[:page] : 1 ;
      @epp = params[:epp];
      @epp_q = (params[:epp] == "-1")? Const::PAGINATION_CONST_HIGH : params[:epp] ;

      @<%= instances_name %> = <%= class_name %>.paginate(:page => @page, :per_page => @epp_q, :order => ord)

      render :layout => false
    end
