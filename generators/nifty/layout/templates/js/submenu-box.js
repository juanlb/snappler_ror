(function( $ ){



  var methods = {

    //FUNCION DE INICIALIZACION
    generate_link_list : function(settings){
      settings.button_element

      settings.button_element.wrap('<span class="submenu-boton">');
      var list = "<span class='submenu-box' id='submenu-box-2'><ul>";
      for (var i in settings.button_list)
      {
        list += "<li><a href='"+settings.button_list[i][1]+"'>"+settings.button_list[i][0]+"</a></li>"
      }
      list += "</ul></span>";
      settings.button_element.parent().append(list);
    }
  };


  $.fn.submenu_box = function(options) {


    var settings = $.extend({
      'button_element' : $(this),
      'button_list' : [['elem1', 'http://www.google.com'],
                      ['elem2', 'http://www.google.com'],
                      ['elem3', 'http://www.google.com'],
                      ['elem4', 'http://www.google.com']]
    }, options);

    methods.generate_link_list(settings);

  };


})( jQuery );







