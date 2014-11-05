/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
/****
Auto Inserted Help Dialogs
***
Requirements:
jQuery 1.3.2
jQuery UI 1.7.2 (Dialog and all effects)
***

Looks for <a> elements with a class of help_dialog_link, replaces the element with a help icon that will dynamically loaded help text from a given URL on click.

Include this file in the head of the page, and add the following:
---
<script>
	$(document).ready(function() {
		options = {
			icon:"/images/question_mark.jpg",
			helper_class:"help_dialog"
		}
		display_helpers(options);
	});
</script>
---
Options are not required.
	icon will default to "[?]". It can be passed text, the URI of a JPG,GIF, or PNG, or the entire <img> tag for custom styling.
	helper_class will default to "help_dialog". This class will be applied to the dialog boxes, so that they can be styled.

Example elements look like this:
---
	<a href="/help/1.html" id="help_link_1" class="help_dialog_link" data-style="dialog">Help</a>
	<a href="/help/1.html" id="help_link_1" class="help_dialog_link" data-style="dialog" modal="true">Help</a>
	<a href="/help/1.html" id="help_link_1" class="help_dialog_link" data-style="clip">Help</a>
	<a href="/help/1.html" id="help_link_1" class="help_dialog_link" data-style="fold">Help</a>
---
Class is required, and must include 'help_dialog_link', though other classes can be used and will be applied to the inserted help icon or text.
ID is not required. Any ID can be used, but should be unique to the page. If no ID is provided, a random one will be generated.
data-style is not required. If no data-style is provided, the default of 'slide' will be used.

A link will be created using the supplied icon, pointing to the href of the element.
However, instead of opening the given page, it will be loaded via AJAX and inserted in to a dialog box, as defined in the "data-style" attribute.

Valid data-styles are the animation effects in jQuery UI, plus the Dialog widget (normal or modal), listed below:
---
clip
dialog
drop
explode
fold
puff
slide
scale
---

data-style="dialog" also has the option of modal="true". If passed, the dialog window will be modal and unmovable on the screen until the user closes it.
****/

function display_helpers(options) {
  //Assign values from options
  if (options != null) {
    set_icon_to(options['icon']);
    set_helper_class_to(options['helper_class']);
  }
  else {
    set_icon_to();
    set_helper_class_to();
  }
  $("a.help_link").each(function(index,element) {
    //ID must be set to use this, so add one if there isn't one.
    if ($(element).attr("id") == "") { $(element).attr("id", random_string()); }
    append_help_to(element);
  });
  $(".help_link").click(function() { display_help_for(this); return false; });
}

function append_help_to(element) {
  if ($(element).attr("title") == undefined) {
    title = $(element).attr("title");
  } else {
    title = $(element).html();
  }
  var helperDiv = document.createElement('div');
  helperDiv.setAttribute("id", 
    $(element).attr("id")+"_"+$(element).attr("data-style"));
  helperDiv.setAttribute("class", $(element).attr("data-style")+" "+helper_class);
  helperDiv.setAttribute("style", "display:none;");
  helperDiv.setAttribute("title", title);

  console.log(element);
  console.log(helperDiv);
  console.log(icon);
  
  $(element).after(helperDiv);
  $(element).html(icon)
}

function display_help_for(element) {
  url = $(element).attr("href"); //The URL to load via AJAX
  help_text_element = 
    "#_"+$(element).attr("id")+"_"+
    $(element).attr("data-style");
  //If the content is already loaded, don't get it again
  if ($(help_text_element).html() == "") {
    $.get(url, { },
      function(data){
        $(help_text_element).html(data);
        if ($(element).attr("data-style") == "dialog") { 
          activate_dialog_for(element,$(element).attr("data-modal"));
        }
        toggle_display_of(help_text_element);
    });
  }
  else { toggle_display_of(help_text_element); }
}
function toggle_display_of(element) { //Toggles for the different display modes
  switch(display_method_of(element)) {
    case "dialog": //open the element using the dialog widget from jQuery UI
      if ($(element).dialog('isOpen')) { 
        $(element).dialog('close'); 
      } 
      else { 
        $(element).dialog('open'); 
      } 
      break;
    case "undefined":
      $(element).toggle("slide"); 
      break;
    default:
      $(element).toggle(display_method);
  }
}
function display_method_of(element) {
  helper_class_regex = new RegExp(" "+helper_class);
  if ($(element).hasClass("dialog"))
    { display_method = "dialog"; }
  else
    { display_method = $(element).attr("class").replace(helper_class_regex,""); }
  return display_method;
}
function activate_dialog_for(element,modal) {
  if (modal == "true") 
    { $("#"+$(element).attr("id")+"_dialog").dialog({modal:true, 
                                                    draggable: false, 
                                                    autoOpen: false }); }
  else 
    { $("#"+$(element).attr("id")+"_dialog").dialog({ autoOpen: false }); }
}

function set_icon_to(help_icon) {
  is_image = /jpg|jpeg|png|gif$/
  if (help_icon = undefined) 
    { icon = "[?]"; } 
  else if (is_image.test(help_icon))
    { icon = "<img src='"+help_icon+"'>"; }
  else
    { icon = help_icon; }
}

function set_helper_class_to(class_name) {
  if (class_name == undefined)
    { helper_class = "help_dialog"; }
  else
    { helper_class = class_name; }
}

function random_string() {
  var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
  var string_length = 8;
  var randomstring = '';
  for (var i=0; i<string_length; i++) {
    var rnum = Math.floor(Math.random() * chars.length);
    randomstring += chars.substring(rnum,rnum+1);
  }
  return randomstring;
}