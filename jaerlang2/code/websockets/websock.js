/***
 * Excerpted from "Programming Erlang, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
***/
function connect(host, port, mod){
    make_live_buttons();
    make_live_inputs();
    var ws = 'ws://' + host + ':' + port + '/websocket/' + mod;
    start_session(ws);
    
}

function onClose(evt) {
    // change the color of the display when the socket closes
    // so we can see it closed
    document.body.style.backgroundColor='#aabbcc';
}  
  
function onMessage(evt) {
    var json = JSON.parse(evt.data);
    do_cmds(json);
}
  
function onError(evt) { 
    // if we get an error change the color of the display so we 
    // can see we got an error
    document.body.style.backgroundColor='orange';
}  
  
function send(msg) {
    websocket.send(msg);
}
  
function start_session(wsUri){
    websocket           = new WebSocket(wsUri); 
    websocket.onopen    = onOpen;
    websocket.onclose   = onClose;
    websocket.onmessage = onMessage; 
    websocket.onerror   = onError;
    return(false);
}  
    
function onOpen(evt) { 
    // console.log("connected");
}

function do_cmds(objs){
    // console.log('do_cmds', objs);
    for(var i = 0; i < objs.length; i++){
	var o = objs[i];
	// as a safety measure we only evaluate js that is loaded
	if(eval("typeof("+o.cmd+")") == "function"){
	    eval(o.cmd + "(o)");
	} else {
	    alert("bad_command:"+o.cmd);
	};
    };
}

function make_live_buttons(){
    $(".live_button").each(
	function(){
	    var b=$(this);
	    var txt = b.text();
	    b.click(function(){
			send_json({'clicked':txt});
		    });
	});
}

function send_json(x){
    send(JSON.stringify(x));
}

// We want the inputs to send a message when we hit CR in the input

function make_live_inputs(){
    $(".live_input").each(
	function(){
	    var e=$(this);
	    var id = e.attr('id');
            // console.log("entry",[e,id]);
	    e.keyup(function(ev){
			if(ev.keyCode==13){
			    read_entry(e, id);
			};
		    });
	    
	});
}
	
function read_entry(x, id){
    var val = x.val();
    x.val(" ");
    send_json({'entry':id, txt:val});
}
    
// browser commands

function append_div(o){
    var x = $("#"+o.id);
    x.append(o.txt);
    x.animate({scrollTop: x.prop("scrollHeight") }, 1000);
}

function fill_div(o){
    $('#'+o.id).html(o.txt);
}

