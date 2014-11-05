/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
// Database reference
var db = null;
window.indexedDB = window.indexedDB || window.mozIndexedDB ||
                   window.webkitIndexedDB ||window.msIndexedDB;

window.shimIndexedDB.__debug(true);  // debugging for the shim
 
// Creates a connection to the local database and specifies the schema version
// Creates the notes table if it doesn't exist.
var connectToDB = function(){
  var version = 1;  
  var request = window.indexedDB.open("awesomenotes", version);

  request.onupgradeneeded = function(event) {
    alert("unupgradeneeded fired");
    var db = event.target.result;
    db.createObjectStore("notes", { keyPath: "id", autoIncrement: true });
  };
  
  request.onsuccess = function(event) {
    db = event.target.result;
    fetchNotes();
  };
  
  request.onerror = function(event){
    alert(event.debug[1].message);
  }
};

// loads all records from the notes table of the database;
var fetchNotes = function(){
  var keyRange, request, result, store, transaction;
  
  transaction = db.transaction(["notes"], "readwrite");
  store = transaction.objectStore("notes");

  // Get everything in the store;
  keyRange = IDBKeyRange.lowerBound(0);
  request = store.openCursor(keyRange);

  request.onsuccess = function(event) {
    result = event.target.result;
    if(result){      
      addToNotesList(result.key, result.value);
      result.continue();
    }
  };
  
  request.onerror = function(event) {
    alert("Unable to fetch records.");
  };
};

// loads a single note from the notes table using the given id
var getNote = function(id){
  var request, store, transaction;
  // assume the id is coming in as a string
  id = parseInt(id);
  
  transaction = db.transaction(["notes"]);
  store = transaction.objectStore("notes");
  
  request = store.get(id);

  request.onsuccess = function(event) {
    showNote(request.result);
  };
  
  request.onerror = function(error){
    alert("Unable to fetch record " + id);
  };
}


var insertNote = function(title, note){
  var data, key
  
  data = {
    "title": title,
    "note": note,
  };
  
  var transaction = db.transaction(["notes"], "readwrite");
  var store = transaction.objectStore("notes");
  var request = store.put(data);
  
  request.onsuccess = function(event) {
    key = request.result;
    addToNotesList(key, data);
    newNote();
  };
};

var updateNote = function(id, title, note){
  var data, request, store, transaction;
  id = parseInt(id);
  data = {
    "title": title,
    "note": note,
    "id" : id 
  };
  
  transaction = db.transaction(["notes"], "readwrite");
  store = transaction.objectStore("notes");
  request = store.put(data);
  
  request.onsuccess = function(event) {
    $("#notes>li[data-id=" + id + "]").html(title);
  };
};


var deleteNote = function(id){
  var request, store, transaction;
  
  id = parseInt(id);
  
  transaction = db.transaction(["notes"], "readwrite");
  store = transaction.objectStore("notes");
  request = store.delete(id);
  
  request.onsuccess = function(event) {
    $("#notes>li[data-id=" + id + "]").remove();
    newNote();
  };
};

var clearNotes = function(id){
  var request, store, transaction;
  
  transaction = db.transaction(["notes"], "readwrite");
  store = transaction.objectStore("notes");
  request = store.clear();
  
  request.onsuccess = function(event) {
    $("#notes").empty();
  };
  
  request.onerror = function(event){
    alert("Unable to clear things out.");
  }
};


// Adds the list item to the list of notes, given an id and a title.
var addToNotesList = function(key, data){
  var item = $("<li>");
  var notes = $("#notes");
  
  item.attr("data-id", key);
  item.html(data.title);               
  notes.append(item);
};

// display the individual note in the form for editing
var showNote = function(data){
  var note = $("#note");
  var title = $("#title");
  
  title.val(data.title);
  title.attr("data-id", data.id);
  note.val(data.note);
  $("#delete_button").show();
}

// Clears out the form and hides the "delete" button
var newNote = function(){
  var note = $("#note");
  var title = $("#title");
  
  $("#delete_button").hide();
  title.removeAttr("data-id");
  title.val("");
  note.val("");
}


$("#save_button").click(function(event){
  var id, note, title;
  
  event.preventDefault();
  note = $("#note");
  title = $("#title");
  id = title.attr("data-id");
  
  if(id){
    updateNote(id, title.val(), note.val());
  }else{
    insertNote(title.val(), note.val());
  }
});


$("#delete_button").click(function(event){
  var title = $("#title");
  event.preventDefault();
  deleteNote(title.attr("data-id"));
});

$("#notes").click(function(event){
  var element = $(event.target);
  if (element.is('li')) {
    getNote(element.attr("data-id"));
  }
});

$("#new_button").click(function(event){
  newNote();
});

$("#delete_all_button").click(function(event){
  clearNotes();
});


connectToDB();
newNote();  

