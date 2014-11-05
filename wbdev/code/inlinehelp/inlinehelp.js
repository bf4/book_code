/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
$(function() {
  var options = {
    helperClass:"help_dialog"
  }
  
  displayHelpers(options);
});

function displayHelpers(options) {
  if (options != null) {
    setIconTo(options['icon']);
    setHelperClassTo(options['helper_class']);
  }
  
  else {
    setIconTo();
    setHelperClassTo();
  }
  
  $("a.help_link").each(function(index,element) {
    if ($(element).attr("id") == "") { $(element).attr("id", randomString()); }
    appendHelpTo(element);
  });
  $("a.help_link").click(function() { displayHelpFor(this); return false; });
}

function appendHelpTo(element) {
  if ($(element).attr("title") != undefined) {
    title = $(element).attr("title"); 
  } else {
    title = $(element).html();
  }
  var helperDiv = document.createElement('div');
  helperDiv.setAttribute("id", 
    $(element).attr("id") + "_" + $(element).attr("data-style"));
  helperDiv.setAttribute("class", 
    $(element).attr("data-style") +" "+ helperClass);
  helperDiv.setAttribute("style", "display:none;");
  helperDiv.setAttribute("title", title);

  $(element).after(helperDiv);
  $(element).html(icon);
}

function displayHelpFor(element) {
  url = $(element).attr("href");
  helpTextElement = "#"+$(element).attr("id") + "_" +
    $(element).attr("data-style");
  if ($(helpTextElement).html() == "") {
    $.get(url, { },
      function(data){
        $(helpTextElement).html(data);
        if ($(element).attr("data-style") == "dialog") { 
          activateDialogFor(element, $(element).attr("data-modal"));
        }
        toggleDisplayOf(helpTextElement);
    });
  }
  else { toggleDisplayOf(helpTextElement); }
}
function toggleDisplayOf(element) {
  switch(displayMethodOf(element)) {
    case "dialog":
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
      $(element).toggle(displayMethod);
  }
}
function displayMethodOf(element) {
  helperClassRegex = new RegExp(" "+helperClass);
  if ($(element).hasClass("dialog"))
    { displayMethod = "dialog"; }
  else
    { displayMethod = $(element).attr("class").replace(helperClassRegex,""); }
  return displayMethod;
}
function activateDialogFor(element,modal) {
  var dialogOptions = { autoOpen: false };
  if (modal == "true") {
    dialogOptions = {
      modal: true,
      draggable: false,
      autoOpen: false
    };
  }
  $("#"+$(element).attr("id")+"_dialog").dialog(dialogOptions);
}

function setIconTo(helpIcon) {
  isImage = /jpg|jpeg|png|gif$/
  if (helpIcon == undefined)
    { icon = "[?]"; } 
  else if (isImage.test(helpIcon))
    { icon = "<img src='"+helpIcon+"'>"; }
  else
    { icon = helpIcon; }
}

function setHelperClassTo(className) {
  if (className == undefined)
    { helperClass = "help_dialog"; }
  else
    { helperClass = className; }
}

function randomString() {
  var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
  var stringLength = 8;
  var randomstring = '';
  for (var i=0; i<stringLength; i++) {
    var rnum = Math.floor(Math.random() * chars.length);
    randomstring += chars.substring(rnum,rnum+1);
  }
  return randomstring;
}
