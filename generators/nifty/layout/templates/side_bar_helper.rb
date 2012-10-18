module SideBarHelper


  def self.get_sidebar(controller,action)

    #Hash Menu
    hash_sidebar = {
      "menu1" => {
        "side1" => {
          :label => "Tareas",
          :url => "/horses",
          :img => "sheduled_task.png",
          :selected => false
        },
        "side2" => {
          :label => "Usuarios",
          :url => "#",
          :img => "user.png",
          :selected => false
        },
        "side3" => {
          :label => "Productos",
          :url => "#",
          :img => "ruby.png",
          :selected => false
        }
      },
      "menu2" => {
        "side1" => {
          :label => "Personal",
          :url => "#",
          :img => "ruby.png",
          :selected => false
        }
      }
    }

    #Hash de activa
    hash_controller = Hash[
      "horses" => ["menu1", "side1"],
      "horses/new" => ["menu1","side2"],
      "horses/show" => ["menu2","side1"]
    ]

    html = self.generate_sidebar_links(controller,action,hash_sidebar, hash_controller)

    return html
  end


  private
  
  def self.generate_sidebar_links(controller,action, hash_sidebar, hash_controller)

    #key completa
    controller_action = "#{controller}/#{action}"

    #Html a imprimir
    activa = ""
    if((hash_controller.has_key?(controller))&&!(hash_controller.has_key?(controller_action)))              #si tiene el controlador solo? (Acceso de menu a Todo el Contorlador)
      sidebar_menu = hash_controller[controller].first              #devuelve la key para ver q activa es
      activa = hash_controller[controller].second              #devuelve la key para ver q activa es
      (!hash_sidebar[sidebar_menu][activa].blank?)? hash_sidebar[sidebar_menu][activa][:selected] = true : ""
    else                                                      #si no esta esa key comprueba si esta con la action ej: "controller/action"
      if(hash_controller.has_key?(controller_action))   #si tiene el controlador/action? (Acceso de menu a por Action)
        sidebar_menu = hash_controller[controller_action].first          #devuelve la key para ver q activa es
        activa = hash_controller[controller_action].second          #devuelve la key para ver q activa es
        (!hash_sidebar[sidebar_menu][activa].blank?)? hash_sidebar[sidebar_menu][activa][:selected] = true : ""
      end
    end

    html = ""

    if(!hash_sidebar[sidebar_menu].blank?)
      for menu_elem in hash_sidebar[sidebar_menu]
        html += "<li "+((menu_elem.second[:selected])? "class='activa'" : '')+"><a href='#{menu_elem.second[:url]}'><img src='/assets/icons-menu/#{menu_elem.second[:img]}' alt='#{menu_elem.second[:img]}'><span>#{menu_elem.second[:label]}</span></a></li>"
      end
    end

	if(!(html == ""))
      html = "<div id='sidebar'><ul>"+html+"</ul></div><!-- sidebar -->"
	  return_side = true
    else
      return_side = false
    end
    
    return html.html_safe, return_side
  end

  
end
