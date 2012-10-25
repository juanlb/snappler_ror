//i18n
jQuery(function($){
  $.datepicker.regional['es'] = {
    closeText: 'Cerrar',
    prevText: '&#x3c;Ant',
    nextText: 'Sig&#x3e;',
    currentText: 'Hoy',
    monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
    'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
    monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun',
    'Jul','Ago','Sep','Oct','Nov','Dic'],
    dayNames: ['Domingo','Lunes','Martes','Mi&eacute;rcoles','Jueves','Viernes','S&aacute;bado'],
    dayNamesShort: ['Dom','Lun','Mar','Mi&eacute;','Juv','Vie','S&aacute;b'],
    dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','S&aacute;'],
    weekHeader: 'Sm',
    dateFormat: 'dd/mm/yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
  };
  $.datepicker.setDefaults($.datepicker.regional['es']);
});


$(document).ready(function() {

//Por defecto inicializa los datepicker de clase
  $.datepicker.setDefaults($.datepicker.regional['es']);
  $( ".datepicker" ).datepicker({
    dateFormat: "dd/mm/yy",
    showOn: "both",
    buttonImage: "/assets/calendar.png",
    buttonImageOnly: true,
    showAnim: "slide"
  });

//Por defecto inicializa los de tipo file
  $("input.file").si();


//Para q el menu scrolee con waypoint
	$('.top').addClass('hidden');
	$.waypoints.settings.scrollThrottle = 30;
	$('#principal').waypoint(function(event, direction) {
		if(direction == "up"){
			$(this).removeClass('sticky');
			$("#sidebar ul").removeClass('sticky');
			$("#panel-der").removeClass('sticky');
			$("#panel-izq").removeClass('sticky');
		}
	}, {
		offset: '0'
	}).find('#upbar').waypoint(function(event, direction) {
		if(direction == "down"){
			$(this).parent().addClass('sticky');
			$("#sidebar ul").addClass('sticky');
			$("#panel-der").addClass('sticky');
			$("#panel-izq").addClass('sticky');
		}
		event.stopPropagation();
	});




});

