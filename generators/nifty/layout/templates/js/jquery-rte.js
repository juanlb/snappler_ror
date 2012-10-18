/*
* jQuery RTE plugin 0.5.1 - create a rich text form for Mozilla, Opera, Safari and Internet Explorer
*
* Copyright (c) 2009 Batiste Bieler
* Distributed under the GPL Licenses.
* Distributed under the MIT License.
*/

// define the rte light plugin
(function($) {

if(typeof $.fn.rte === "undefined") {

    var defaults = {
        media_url: "images/rte/",
        content_css_url: "css/elements/rte.css",
        dot_net_button_class: null,
        max_height: 350
    };

    $.fn.rte = function(options) {

    $.fn.rte.html = function(iframe) {
        return iframe.contentWindow.document.getElementsByTagName("body")[0].innerHTML;
    };

    // build main options before element iteration
    var opts = $.extend(defaults, options);

    // iterate and construct the RTEs
    return this.each( function() {
        var textarea = $(this);
        var iframe;
        var element_id = textarea.attr("id");

        // enable design mode
        function enableDesignMode() {

            var content = textarea.val();

            // Mozilla needs this to display caret
            if($.trim(content)=='') {
                content = '<br />';
            }

            // already created? show/hide
            if(iframe) {
                console.log("already created");
                textarea.hide();
                $(iframe).contents().find("body").html(content);
                $(iframe).show();
                $("#toolbar-" + element_id).remove();
                textarea.before(toolbar());
                return true;
            }

            // for compatibility reasons, need to be created this way
            iframe = document.createElement("iframe");
            iframe.frameBorder=0;
            iframe.frameMargin=0;
            iframe.framePadding=0;
            iframe.height=200;
            if(textarea.attr('class'))
                iframe.className = textarea.attr('class');
            if(textarea.attr('id'))
                iframe.id = element_id;
            if(textarea.attr('name'))
                iframe.title = textarea.attr('name');

            textarea.after(iframe);

            var css = "";
            if(opts.content_css_url) {
                css = "<link type='text/css' rel='stylesheet' href='" + opts.content_css_url + "' />";
            }

            var doc = "<html><head>"+css+"</head><body class='frameBody'>"+content+"</body></html>";
            tryEnableDesignMode(doc, function() {
                $("#toolbar-" + element_id).remove();
                textarea.before(toolbar());
                // hide textarea
                textarea.hide();

            });

        }

        function tryEnableDesignMode(doc, callback) {
            if(!iframe) { return false; }

            try {
                iframe.contentWindow.document.open();
                iframe.contentWindow.document.write(doc);
                iframe.contentWindow.document.close();
            } catch(error) {
                //console.log(error);
            }
            if (document.contentEditable) {
                iframe.contentWindow.document.designMode = "On";
                callback();
                return true;
            }
            else if (document.designMode != null) {
                try {
                    iframe.contentWindow.document.designMode = "on";
                    callback();
                    return true;
                } catch (error) {
                    //console.log(error);
                }
            }
            setTimeout(function(){tryEnableDesignMode(doc, callback)}, 500);
            return false;
        }

        function disableDesignMode(submit) {
            var content = $(iframe).contents().find("body").html();

            if($(iframe).is(":visible")) {
                textarea.val(content);
            }

            if(submit !== true) {
                textarea.show();
                $(iframe).hide();
            }
        }

        // create toolbar and bind events to it's elements
        function toolbar() {
            var tb = $("<div class='rte-toolbar' id='toolbar-"+ element_id +"'><div>\
                <p>\
                    <select class='fontsize'>\
                        <option value='2'>Font Size 1</option>\
                        <option value='3'>Font Size 2</option>\
                        <option value='4'>Font Size 3</option>\
                        <option value='5'>Font Size 4</option>\
                    </select>\
                </p>\
                <p>\
                    <a href='#' class='bold'><img src='"+opts.media_url+"bold.png' alt='bold' /></a>\
                    <a href='#' class='italic'><img src='"+opts.media_url+"italic.png' alt='italic' /></a>\
					<a href='#' class='underline'><img src='"+opts.media_url+"underline.png' alt='underline' /></a>\
				</p>\
				<p>\
                    <a href='#' class='backgroundcolor'><img src='"+opts.media_url+"background.png' alt='backgroundcolor' /></a>\
					<span class='rte-submenu backgroundcolor' >\
						<a class='backgroundcolor-black' href='#'>&nbsp;</a>\
						<a class='backgroundcolor-gray' href='#'>&nbsp;</a>\
						<a class='backgroundcolor-white' href='#'>&nbsp;</a><br/>\
						<a class='backgroundcolor-red' href='#'>&nbsp;</a>\
						<a class='backgroundcolor-yellow' href='#'>&nbsp;</a>\
						<a class='backgroundcolor-green' href='#'>&nbsp;</a><br/>\
						<a class='backgroundcolor-blue-light' href='#'>&nbsp;</a>\
						<a class='backgroundcolor-blue' href='#'>&nbsp;</a>\
						<a class='backgroundcolor-violet' href='#'>&nbsp;</a>\
					</span>\
				</p>\
				<p>\
					<a href='#' class='color'><img src='"+opts.media_url+"color.png' alt='color' /></a>\
					<span class='rte-submenu color' >\
						<a class='color-black' href='#'>&nbsp;</a>\
						<a class='color-gray' href='#'>&nbsp;</a>\
						<a class='color-white' href='#'>&nbsp;</a><br/>\
						<a class='color-red' href='#'>&nbsp;</a>\
						<a class='color-yellow' href='#'>&nbsp;</a>\
						<a class='color-green' href='#'>&nbsp;</a><br/>\
						<a class='color-blue-light' href='#'>&nbsp;</a>\
						<a class='color-blue' href='#'>&nbsp;</a>\
						<a class='color-violet' href='#'>&nbsp;</a>\
					</span>\
                </p>\
                <p>\
                    <a href='#' class='unorderedlist'><img src='"+opts.media_url+"unordered.png' alt='unordered list' /></a>\
					<a href='#' class='orderedlist'><img src='"+opts.media_url+"ordered.png' alt='ordered list' /></a>\
                    <a href='#' class='link'><img src='"+opts.media_url+"link.png' alt='link' /></a>\
					<a href='#' class='unlink'><img src='"+opts.media_url+"unlink.png' alt='unlink' /></a>\
                    <a href='#' class='image'><img src='"+opts.media_url+"image.png' alt='image' /></a>\
					<a href='#' class='removeformat'><img src='"+opts.media_url+"removeformat.png' alt='removeformat' /></a>\
                    <a href='#' class='disable'><img src='"+opts.media_url+"close.png' alt='close rte' /></a>\
                </p></div></div>");



            $('.fontsize', tb).change(function(){
                var index = this.selectedIndex;
                if( index!=0 ) {
                    var selected = this.options[index].value;
                    formatText('fontSize', selected);
                }
            });
			$('.removeformat', tb).click(function(){ formatText('removeformat');return false; });
            $('.bold', tb).click(function(){ formatText('bold');return false; });
            $('.italic', tb).click(function(){ formatText('italic');return false; });
			$('.underline', tb).click(function(){ formatText('underline');return false; });

			$('.backgroundcolor', tb).click(function(){ 
				estado = $(this).first().next().css('visibility');
				if(estado == "visible"){ $(this).first().next().css('visibility','hidden'); }
				else{ $('.rte-submenu', tb).css('visibility','hidden');$(this).first().next().css('visibility','visible'); }
			return false; });
			
			$('.backgroundcolor-black', tb).click(function(){ formatText('hiliteColor', '#000000'); $('a.backgroundcolor', tb).css('background-color','#000000');$(this).parent().css('visibility','hidden');return false; });
			$('.backgroundcolor-gray', tb).click(function(){ formatText('hiliteColor', '#888888'); $('a.backgroundcolor', tb).css('background-color','#888888');$(this).parent().css('visibility','hidden');return false; });			
			$('.backgroundcolor-white', tb).click(function(){ formatText('hiliteColor', '#FFFFFF'); $('a.backgroundcolor', tb).css('background-color','#FFFFFF');$(this).parent().css('visibility','hidden');return false; });			
			$('.backgroundcolor-red', tb).click(function(){ formatText('hiliteColor', '#FF0000'); $('a.backgroundcolor', tb).css('background-color','#FF0000');$(this).parent().css('visibility','hidden');return false; });
			$('.backgroundcolor-yellow', tb).click(function(){ formatText('hiliteColor', '#FFFF00'); $('a.backgroundcolor', tb).css('background-color','#FFFF00');$(this).parent().css('visibility','hidden');return false; });			
			$('.backgroundcolor-green', tb).click(function(){ formatText('hiliteColor', '#00FF00'); $('a.backgroundcolor', tb).css('background-color','#00FF00');$(this).parent().css('visibility','hidden');return false; });			
			$('.backgroundcolor-blue-light', tb).click(function(){ formatText('hiliteColor', '#00FFFF'); $('a.backgroundcolor', tb).css('background-color','#00FFFF');$(this).parent().css('visibility','hidden');return false; });
			$('.backgroundcolor-blue', tb).click(function(){ formatText('hiliteColor', '#0000FF'); $('a.backgroundcolor', tb).css('background-color','#0000FF');$(this).parent().css('visibility','hidden');return false; });
			$('.backgroundcolor-violet', tb).click(function(){ formatText('hiliteColor', '#FF00FF'); $('a.backgroundcolor', tb).css('background-color','#FF00FF');$(this).parent().css('visibility','hidden');return false; });            



			$('.color', tb).click(function(){ 
				estado = $(this).first().next().css('visibility');
				if(estado == "visible"){ $(this).first().next().css('visibility','hidden'); }
				else{ $('.rte-submenu', tb).css('visibility','hidden');$(this).first().next().css('visibility','visible'); }
			return false; });
			
			$('.color-black', tb).click(function(){ formatText('foreColor', '#000000'); $('a.color', tb).css('background-color','#000000');$(this).parent().css('visibility','hidden');return false; });
			$('.color-gray', tb).click(function(){ formatText('foreColor', '#888888'); $('a.color', tb).css('background-color','#888888');$(this).parent().css('visibility','hidden');return false; });			
			$('.color-white', tb).click(function(){ formatText('foreColor', '#FFFFFF'); $('a.color', tb).css('background-color','#FFFFFF');$(this).parent().css('visibility','hidden');return false; });			
			$('.color-red', tb).click(function(){ formatText('foreColor', '#FF0000'); $('a.color', tb).css('background-color','#FF0000');$(this).parent().css('visibility','hidden');return false; });
			$('.color-yellow', tb).click(function(){ formatText('foreColor', '#FFFF00'); $('a.color', tb).css('background-color','#FFFF00');$(this).parent().css('visibility','hidden');return false; });			
			$('.color-green', tb).click(function(){ formatText('foreColor', '#00FF00'); $('a.color', tb).css('background-color','#00FF00');$(this).parent().css('visibility','hidden');return false; });			
			$('.color-blue-light', tb).click(function(){ formatText('foreColor', '#00FFFF'); $('a.color', tb).css('background-color','#00FFFF');$(this).parent().css('visibility','hidden');return false; });
			$('.color-blue', tb).click(function(){ formatText('foreColor', '#0000FF'); $('a.color', tb).css('background-color','#0000FF');$(this).parent().css('visibility','hidden');return false; });
			$('.color-violet', tb).click(function(){ formatText('foreColor', '#FF00FF'); $('a.color', tb).css('background-color','#FF00FF');$(this).parent().css('visibility','hidden');return false; });            




			$('.orderedlist', tb).click(function(){ formatText('insertorderedlist');return false; });
            $('.unorderedlist', tb).click(function(){ formatText('insertunorderedlist');return false; });
			$('.unlink', tb).click(function(){ formatText('unlink');return false; });

            $('.link', tb).click(function(){
                var p=prompt("URL:");
                if(p)
                    formatText('CreateLink', p);
                return false; });
	
            $('.image', tb).click(function(){
                var p=prompt("image URL:");
                if(p)
                    formatText('InsertImage', p);
                return false; });

            $('.disable', tb).click(function() {
                disableDesignMode();
                var edm = $('<a class="rte-edm" href="#">Habilitar Modo Dise&ntilde;o</a>');
                tb.empty().append(edm);
                edm.click(function(e){
                    e.preventDefault();
                    enableDesignMode();
                    // remove, for good measure
                    $(this).remove();
                });
                return false;
            });

            // .NET compatability
            if(opts.dot_net_button_class) {
                var dot_net_button = $(iframe).parents('form').find(opts.dot_net_button_class);
                dot_net_button.click(function() {
                    disableDesignMode(true);
                });
            // Regular forms
            } else {
                $(iframe).parents('form').submit(function(){
                    disableDesignMode(true);
                });
            }

            var iframeDoc = $(iframe.contentWindow.document);

            var select = $('.fontsize', tb)[0];
			var rte_submenu = $('.rte-submenu', tb);
			
            iframeDoc.mouseup(function(){
				rte_submenu.css('visibility','hidden');
                setSelectedType(getSelectionElement(), select);
                return true;
            });

            iframeDoc.keyup(function() {
                setSelectedType(getSelectionElement(), select);
                var body = $('body', iframeDoc);
                if(body.scrollTop() > 0) {
                    var iframe_height = parseInt(iframe.style['height'])
                    if(isNaN(iframe_height))
                        iframe_height = 0;
                    var h = Math.min(opts.max_height, iframe_height+body.scrollTop()) + 'px';
                    iframe.style['height'] = h;
                }
                return true;
            });

            return tb;
        };

        function formatText(command, option) {
            iframe.contentWindow.focus();
            try{
                iframe.contentWindow.document.execCommand(command, false, option);
            }catch(e){
                //console.log(e)
            }
            iframe.contentWindow.focus();
        };

        function setSelectedType(node, select) {
            while(node.parentNode) {
                var nName = node.parentNode.size;
                for(var i=0;i<select.options.length;i++) {
                    if(nName==select.options[i].value){
                        select.selectedIndex=i;
                        return true;
                    }
                }
                node = node.parentNode;
            }
            select.selectedIndex=0;
            return true;
        };

        function getSelectionElement() {
            if (iframe.contentWindow.document.selection) {
                // IE selections
                selection = iframe.contentWindow.document.selection;
                range = selection.createRange();
                try {
                    node = range.parentElement();
                }
                catch (e) {
                    return false;
                }
            } else {
                // Mozilla selections
                try {
                    selection = iframe.contentWindow.getSelection();
                    range = selection.getRangeAt(0);
                }
                catch(e){
                    return false;
                }
                node = range.commonAncestorContainer;
            }
            return node;
        };
        
        // enable design mode now
        enableDesignMode();

    }); //return this.each
    
    }; // rte

} // if

})(jQuery);

$(document).ready(function() {
top_res = 23;
left_res = 24;
	$(".rte-submenu").each(function(index){
		$(this)
		top_cur = $(this).offset().top;
		left_cur = $(this).offset().left;

		$(this).css('top', top_cur + top_res);
		$(this).css('left', left_cur - left_res);
	});

});


