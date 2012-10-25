$(document).ready(function() {
  refresh_table_li_functions();

  update_selected_checkbox();

});


function reload_select_pagination(select){
	new_url = $.param.querystring(window.location.href, 'epp='+$(select).val());
	window.location = new_url;
}


function refresh_table_li_functions(){

  $("table.list tbody tr td.clickeable").unbind('click');
  $("table.list thead tr th input.checkbox-table-all").unbind('change');

  $("table.list tbody tr td.clickeable").click(function(){
    check_uncheck_tr($(this).parent());
  });

  $("table.list thead tr th input.checkbox-table-all").change(function(){
    check_uncheck_all($(this));
  });
}

function check_uncheck_all(checkbox){
  if(checkbox.attr("checked")){
    checkbox.parent().parent().parent().parent().find("tbody tr td input.checkbox-table").each(function(index){
      tr = $(this).parent().parent();
      check_tr(tr);
    });
  }
  else
  {
    $("table tbody tr td input.checkbox-table").each(function(index){
      tr = $(this).parent().parent();
      uncheck_tr(tr);
    });
  }
}


function update_selected_checkbox(){
  $("table tbody tr td input.checkbox-table").each(function(index){
    if($(this).attr("checked")){
      tr = $(this).parent().parent();
      check_uncheck_tr(tr);
    }
  });
} 

function check_uncheck_tr(tr){
  if(tr.hasClass("activa")){
    uncheck_tr(tr);
  }
  else
  {
    check_tr(tr);
  }
}

function check_tr(tr){
  tr.addClass("activa");
  tr.find("input.checkbox-table").attr("checked","checked");
//tr.find("td.operations").css('visibility','hidden');
}

function uncheck_tr(tr){
  tr.removeClass("activa");
  tr.find("input.checkbox-table").removeAttr("checked");
//tr.find("td.operations").css('visibility','visible');
}

function send_table_form(element_table_form, action_method){
  $("#"+element_table_form).prepend("<input type='hidden' name='action_method' value='"+action_method+"' />");
  $("#"+element_table_form).submit();
}
