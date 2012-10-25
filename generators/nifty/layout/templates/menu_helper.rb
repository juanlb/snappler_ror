module MenuHelper


  def self.get_upbar(controller,action)

    #Hash Menu
    hash_menu = {
      "menu1" => {
        :label => "Menu 1",
        :url => "/dogs",
        :selected => false
      },
      "menu2" => {
        :label => "Menu 2",
        :url => "#",
        :selected => false
      },
      "menu3" => {
        :label => "Menu 3",
        :url => "#",
        :selected => false
      }
    }

    #Hash de activa
    hash_controller = Hash[
      "dogs" => "menu1"
    ]

    html = self.generate_upbar_links(controller,action,hash_menu, hash_controller)

    return html.html_safe
  end


  private
  def self.generate_upbar_links(controller,action,hash_menu, hash_controller)

    #key completa
    controller_action = "#{controller}/#{action}"

    #Html a imprimir
    activa = ""
    if((hash_controller.has_key?(controller))&&(!hash_controller.has_key?(controller_action)))            #si tiene el controlador solo? (Acceso de menu a Todo el Contorlador)
      activa = hash_controller[controller]              #devuelve la key para ver q activa es
      hash_menu[activa][:selected] = true
    else                                                      #si no esta esa key comprueba si esta con la action ej: "controller/action"
      if(hash_controller.has_key?(controller_action))   #si tiene el controlador/action? (Acceso de menu a por Action)
        activa = hash_controller[controller_action]          #devuelve la key para ver q activa es
        hash_menu[activa][:selected] = true
      end
    end

    html = ""

    for menu_elem in hash_menu
      html += "<li "+((menu_elem.second[:selected])? "class='activa'" : '')+"><a href='#{menu_elem.second[:url]}'>#{menu_elem.second[:label]}</a></li>"
    end

    return html
  end



  
end
