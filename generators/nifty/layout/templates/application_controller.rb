class ApplicationController < ActionController::Base
  protect_from_forgery

#Funcion que se usa en los controladores como before_filter
  def user_required_admin_one
     unless current_user && current_user.has_role?(Const::ROL_ADMIN_LEVEL_ONE)
       flash[:error] = "No tenes Acceso"
       redirect_to root_url and return false
     end
   end

#
#  def user_required_admin_two
#     unless current_user && current_user.has_role?(Const::ROL_ADMIN_LEVEL_TWO)
#       flash[:error] = "No tenes Acceso"
#       redirect_to root_url and return false
#     end
#   end


    private

  def setOrderQuery(default, column, way)
    ord = (column)? column : default ;
    way = (way)? way : "ASC" ;
    return ord + " " + way
  end

end
