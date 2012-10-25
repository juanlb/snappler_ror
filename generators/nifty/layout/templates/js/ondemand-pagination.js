(function( $ ){



  var methods = {

    //FUNCION DE INICIALIZACION
    initialize_ondemand_pagination : function(settings){
      element_per_page = settings.element_per_page;
      actual_page = settings.actual_page;
      if("ajax_url" in settings){
        ajax_url = settings.ajax_url;
      }

      table_container = settings.table_container;
      table_container_id_pref = settings.table_container+"_page_";

      methods.get_first_page(settings);
    },

    //FUNCION Q HACE LA PETICION CUANDO SE PRECIONA UN LINK
    require_page : function(number, settings){
      actual_page = number;

      if($(table_container_id_pref+actual_page).size() == 0){  //SI DA 0 ES Q NO ESTA CARGADA Y SALE POR AJAX
        var params = $.param.querystring(window.location.search, 'page='+actual_page+'&epp='+element_per_page+'&sen='+settings.sen+'&ord='+settings.ord).substr(1);
        options = {
          url: ajax_url,
          param: params,
          fn: function(retorno){
            $(table_container).find("div.combo_table").hide();
            $(table_container).prepend(retorno);
            refresh_table_li_functions(settings); //Funcion de table.js q reinicia las funciones de la tabla
          }
        }
        doTheAjax(options);
        $(table_container_id_pref+actual_page +" .pagination_container a").click(function(){
          methods.require_page($(this).attr('page'), settings);
        });
      }
      else                                                     //SI DA != 0 ESTA Y SOLO LA MUESTRA
      {
        $(table_container).find("div.combo_table").hide();
      }
      $(table_container_id_pref+actual_page).show();
    },


    //FUNCION Q TRAE LA PRIMER PAGINA
    get_first_page : function(settings){
      methods.require_page(actual_page, settings);
    }




  };


  $.fn.ondemand_pagination = function(options) {


    var settings = $.extend( {
      'element_per_page' : 10,
      'actual_page' : 1,
      'pagination_container' : "#pagination_container",
      'table_container' : "#"+this.attr('id'),
      'table_container_id_pref' : "#"+this.attr('id')+"_page_",
      'sen' : "",
      'ord' : "",
      'ajax_url' : "table_ajax.php",
      'link_first' : "&lt;&lt;",
      'link_prev' : "&lt;",
      'link_last' : "&gt;&gt;",
      'link_next' : "&gt;"
    }, options);

    methods.initialize_ondemand_pagination(settings);

  };


})( jQuery );







