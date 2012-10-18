(function( $ ){

  var methods = {
      
    //FUNCION QUE CREA LOS LISTENER
    create_listener_duallistbox : function(listener, settings){
      $(listener).click(function(){
        if(!($(this).hasClass('selected')))
        {
          var label = $(this).find("label");
          var inputHidden = $(this).find("input:hidden");
			
          element_value = inputHidden.val();
          element_name = label.html();
          li = $(document.createElement('li'));
          label = $(document.createElement('label'));
          input_hidden = $(document.createElement('input'));
          delete_button = $(document.createElement('input'));

          li.attr('id',settings.listbox2li_name+settings.name+"-"+element_value);
          label.html(element_name);
          input_hidden.attr({
            name: settings.name+"[]",
            id: settings.listbox2hidden_name+settings.name+"-"+element_value,
            value: element_value,
            type: 'hidden'
          });
          delete_button.attr({
            id: settings.listbox2deletebutton_name+settings.name+"-"+element_value,
            value: '&nbsp',
            class: 'delete',
            type: 'button'
          });

		
          li.append(label);
          li.append(input_hidden);
          li.append(delete_button);

          private_methods.elementDelete(settings, delete_button);
			
          $(this).addClass("selected");

          listbox2ul = $("#"+settings.listbox2ul_name+settings.name);
          listbox2ul.append(li);
        }
      });
    },

    //FUNCION QUE CREA LOS OBJETOS HTML
    create_element_html_duallistbox : function(container, settings){

      var elements_parsed = private_methods.convert_array_to_analize(settings.elements);

      var label_container = $(document.createElement('label'));

      var listbox1 = $(document.createElement('div'));
      var listbox2 = $(document.createElement('div'));

      var listbox1ul = $(document.createElement('ul'));
      var listbox2ul = $(document.createElement('ul'));

      container.addClass("duallistbox");

      label_container.html(settings.label);

      listbox1.attr({
        id: settings.listbox1_name+settings.name,
        class: 'listbox1'
      });
      listbox2.attr({
        id: settings.listbox2_name+settings.name,
        class: 'listbox2'
      });

      listbox1ul.attr({
        id: settings.listbox1ul_name+settings.name,
        class: 'listbox'
      });
      listbox2ul.attr({
        id: settings.listbox2ul_name+settings.name,
        class: 'listbox'
      });


      for (var i in settings.elements)
      {
        element_value = settings.elements[i].value;
        element_name = settings.elements[i].name;
        li = $(document.createElement('li'));
        label = $(document.createElement('label'));
        input_hidden = $(document.createElement('input'));

        li.attr('id',settings.listbox1li_name+settings.name+"-"+element_value);
        if(jQuery.inArray(element_value, settings.selected) != "-1"){
          li.attr('class','selected');
        }


        label.html(element_name);
        input_hidden.attr({
          id: settings.listbox1hidden_name+settings.name+"-"+element_value,
          value: element_value,
          type: 'hidden'
        });

        li.append(label);
        li.append(input_hidden);

        listbox1ul.append(li);
      }

      for (var j in settings.selected)
      {
        element_value = settings.selected[j];
        element_name = elements_parsed[element_value];
        li = $(document.createElement('li'));
        label = $(document.createElement('label'));
        input_hidden = $(document.createElement('input'));
        delete_button = $(document.createElement('input'));

        li.attr('id',settings.listbox2li_name+settings.name+"-"+element_value);
        label.html(element_name);
        input_hidden.attr({
          name: settings.name+"[]",
          id: settings.listbox2hidden_name+settings.name+"-"+element_value,
          value: element_value,
          type: 'hidden'
        });
        delete_button.attr({
          id: settings.listbox2deletebutton_name+settings.name+"-"+element_value,
          value: '&nbsp',
          class: 'delete',
          type: 'button'
        });


        li.append(label);
        li.append(input_hidden);
        li.append(delete_button);

        private_methods.elementDelete(settings, delete_button);

        listbox2ul.append(li);
      }

      listbox1.append(listbox1ul);
      listbox2.append(listbox2ul);


      container.append(label_container);
      container.append(listbox1);
      container.append(listbox2);

    },


  };




  var private_methods = {
    //FUNCION USADA POR LA LISTA PARA BORRAR ELEMENTOS SELECCIONADOS
    elementDelete : function(settings, delete_button)
    {
      $(delete_button).click(function(){
          var element_value = $(this).prev().val();
          $(this).parent().remove();
          $("#"+settings.listbox1li_name+settings.name+"-"+element_value).removeClass("selected");
        });
    },

    //FUNCION USADA PARA PARSEAR UNA ARREGLO (PRIVATE)
    convert_array_to_analize : function(elements){
      array_new = [];
      var x;
      for (x in elements)
      {
        array_new[elements[x].value] = elements[x].name;
      }

      return array_new;
    }
  };


  $.fn.duallistbox = function(options) {


    var settings = $.extend( {
      'name'         : 'permisos',
      'label' : 'Permisos',
      'listbox1_name' : "listbox1-",
      'listbox2_name' : "listbox2-",
      'listbox1ul_name' : "listbox1-ul-",
      'listbox2ul_name' : "listbox2-ul-",
      'listbox1li_name' : "listbox1-li-",
      'listbox2li_name' : "listbox2-li-",
      'listbox1hidden_name' : "listbox1-hidden-",
      'listbox2hidden_name' : "listbox2-hidden-",
      'listbox2deletebutton_name' : "listbox2-delete-"
    }, options);

    methods.create_element_html_duallistbox(this, settings);
    listener = "#"+this.attr('id') + " ul#"+settings.listbox1ul_name+settings.name+" li";
    methods.create_listener_duallistbox(listener, settings);


  };

})( jQuery );






//
//
//
//
//
////FUNCION DE INICIALIZACION
//function initialize_duallistbox(name_container, options){
//  var container = $(name_container);
//  var name_element = options.name;
//
//  create_element_html_duallistbox(this, options);
//
//
//  listener = name_container + " ul#"+listbox1ul_name+name_element+" li";
//
//  create_listener_duallistbox(listener, options);
//
//}
//
//
//
