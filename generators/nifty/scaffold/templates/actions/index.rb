    def index
      @ord = params[:ord]
      @sen = params[:sen]
      @breadcrumbs = [["#{t(:<%= instances_name %>).capitalize}", "/<%= instances_name %>"]]
    end
