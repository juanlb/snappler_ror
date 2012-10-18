//************************************************************************************************************************************************************************
//**																																				**
//**													AJAX FUNCTIONS																				**
//**																																				**
//*************************************************************************************************************************************************************************
function loadingAjax(div) 	//Funcion que muestra un gif de carga en un div en particular (PRIVATE )
{	
	$("#"+div).html("<img alt='Loading' border='0' src='http://www.snappminds.com/mauro/php_template_1_1/images/loading.gif' />");
}
//************************************************************************************
//************************************************************************************
function completeAjax(div)	//Funcion que quita un gif de carga en un div en particular (PRIVATE )
{
	$("#"+div).html("");
}		
//************************************************************************************
//************************************************************************************
function doTheAjax(options)
{
  var type = "GET";
  if("type" in options){
    type = options.type; 
  }
  var async = false;
  if("async" in options){
    async = options.async;
  }
  var url = options.url;
  var param = options.param;
  var fn = options.fn;
	var retorno = "Error";

	$.ajax({
				type: type,
				url: url,
				data: param,
				async : false,
				complete: function(datos)
				{
					retorno = datos;
					fn(retorno.responseText);
				}
			});
			
	return retorno;			
}
//************************************************************************************
//************************************************************************************
function ajaxLoadContainer(options, container)
{	
//  options = {
//            url: "alguna/url",
//            param: "aa=1&bb=2",
//            method: "append"
//  }
  options.fn = function(retorno){
                                  switch (options.method)
                                  {
                                  case "append":
                                    $(container).append(retorno);
                                    break;
                                  case "prepend":
                                    $(container).prepend(retorno);
                                    break;
                                  case "html":
                                    $(container).html(retorno);
                                    break;
                                  }
                                }
	doTheAjax(options);
} 				
