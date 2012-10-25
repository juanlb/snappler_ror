    def index
      @ord = params[:ord]
      @sen = params[:sen]
	  @epp = (params[:epp])? params[:epp] : Const::PAGINATION_CONST
      @breadcrumbs = [["#{t(:<%= instances_name %>).capitalize}", "/<%= instances_name %>"]]
    end
