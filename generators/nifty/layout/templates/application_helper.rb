module ApplicationHelper


  def will_paginate_custom(collection)
    html = ""
    prev_page = collection.current_page - 1
    next_page = collection.current_page + 1
    last_page = collection.total_pages
    first_page = 1

    if(collection.current_page != 1)
      html += "<a href='javascript:;' page='#{first_page}' >&lt;&lt;</a>"
      html += "<a href='javascript:;' page='#{prev_page}' >&lt;</a>"
    end

    for i in 1...(collection.total_pages + 1)
      if(i == collection.current_page)
        html += "<em>#{i}</em>"
      else
        html += "<a href='javascript:;' page='#{i}' >#{i}</a>"
      end
    end


    if (collection.current_page != collection.total_pages)
      html += "<a href='javascript:;' page='#{next_page}' >&gt;</a>"
      html += "<a href='javascript:;' page='#{last_page}' >&gt;&gt;</a>"
    end
    
    return html.html_safe

  end


  def self.flash_message(flash)
    msg = ""
    if flash[:notice]
      msg += "<h4 class='alert_success'>#{flash[:notice]}</h4>"
    end
    if flash[:error]
      msg += "<h4 class='alert_error'>#{flash[:error]}</h4>"
    end
    if flash[:info]
      msg += "<h4 class='alert_info'>#{flash[:info]}</h4>"
    end
    if flash[:warning]
      msg += "<h4 class='alert_warning'>#{flash[:warning]}</h4>"
    end
    return msg.html_safe
  end


  def self.link_to_with_order(view, label, column, params)
    if((params[:ord] == column))
      if((params[:sen]== "ASC"))
        sentido = "DESC"
        clase = "ord-decrescent"
      else
        sentido = "ASC"
        clase = "ord-ascendant"
      end
    else
      sentido = "ASC"
      clase = "ord-ascendant"
    end
    #params.delete(:epp)
    params.delete(:page)
    return view.link_to(label, view.url_for(params.merge(:action => "index", :ord => column, :sen => sentido)), :class => clase)
  end

  
  def self.get_breadcrumbs(breadcrumbs)

	zindex = 15
	html = ""
    if breadcrumbs
      html = "<div id='breadcrumbs'>
				<ul class='crumbs'><li class='first'>
                <a class='first' href='/' style='z-index:#{zindex};'><span></span>Inicio</a>
            </li>"

      for breadcrumb in breadcrumbs
		zindex = zindex - 1
        html += "<li class='breadcrumb #{(breadcrumbs.last == breadcrumb)? 'active' : ''}'>
                  <a href='#{breadcrumb.second}' style='z-index:#{zindex};'>#{breadcrumb.first}</a>
              </li>"
      end
	  html += "<div style='clear:both'></ul>
	      	</div>"
    end
    return html.html_safe
  end

  
end
