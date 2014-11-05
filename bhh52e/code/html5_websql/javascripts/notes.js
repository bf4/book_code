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

// Creates a connection to the local database
var connectToDB = function(){
  db = window.openDatabase('awesome_notes', '1.0',
                                 'AwesomeNotes Database', 1024*1024*3);
};



//Create the table method
createNotesTable = function(){
  db.transaction(function(tx){
    tx.executeSql(
      "CREATE TABLE notes (id INTEGER \
       PRIMARY KEY, title TEXT, note TEXT)", [],
      function(){ alert('Notes database created successfully!'); },
      function(tx, error){ alert(error.message); } );
  });
};

//Insert record into Table.
var insertNote = function(title, note){
  db.transaction(function(tx){
    tx.executeSql("INSERT INTO notes (title, note) VALUES (?, ?)", 
                   [title, note],
      function(tx, result){ 
        var id = result.insertId ;
        addToNotesList(id, title);
        newNote();
      },
      function(){ 
        alert('The note could not be saved.'); 
      }
    );
  });
};


/* update record into Table. Takes the Title field and Note field
   which are both jQuery objects. The id to update is a custom data attribute on the title field.
*/

var updateNote = function(id, title, note){
  db.transaction(function(tx){
    tx.executeSql("UPDATE notes set title = ?, note = ? where id = ?",
                [title, note, id],
      function(tx, result){ 
        alert('Record ' + id + ' updated!');
        $("#notes>li[data-id=" + id + "]").html(title);
      },
      function(){ 
        alert('The note was not updated!');
      }
    );
  });
};


//remove record from Table.
var deleteNote = function(id){
 db.transaction(function(tx){
    tx.executeSql("DELETE from notes where id = ?", [id],
      function(tx, result){ 
       alert('Record ' + id + ' deleted!');
       $("#notes>li[data-id=" + id + "]").remove();
      },
      function(){ 
       alert('The note was not deleted!');
      }
    );
 });
};


// loads all records from the notes table of the database;
var fetchNotes = function(){
  db.transaction(function(tx) {
      tx.executeSql('SELECT id, title, note FROM notes', [],
        function(SQLTransaction, data){
          for (var i = 0; i < data.rows.length; ++i) {
              var row = data.rows.item(i);
              var id = row['id'];
              var title = row['title'];

              addToNotesList(id, title);
          }
        }
      );
  });
};

var clearNotes = function(){
  db.transaction(function(tx){
     tx.executeSql("DELETE from notes",
       function(tx, result){ 
         $("#notes").empty();
       },
       function(){ 
         alert('Unable to clear things out.'); 
       }
     );
  });
};

// Adds the list item to the list of notes, given an id and a title.
var addToNotesList = function(id, title){
  var notes = $("#notes");
  var item = $("<li>");
  item.attr("data-id", id);
  item.html(title);               
  notes.append(item);
};


// loads a single note from the notes table using the given id
var getNote = function(id){
  db.transaction(function(tx) {
    tx.executeSql('SELECT id, title, note FROM notes where id = ?', [id],
      function(SQLTransaction, data){
        var row = data.rows.item(0);
        var title = $("#title");
        var note = $("#note");
        title.val(row["title"]);
        title.attr("data-id", row["id"]);
        note.val(row["note"]);
        $("#delete_button").show();
      });
  });
}



// Clears out the form and removes the "delete" button
newNote = function(){
  $("#delete_button").hide();
  var title = $("#title");
  title.removeAttr("data-id");
  title.val("");
  var note = $("#note");
  note.val("");
}


  
$("#save_button").click(function(event){
  event.preventDefault();
  var title = $("#title");
  var note = $("#note");
  var id = title.attr("data-id");
  
  if(id){
    updateNote(id, title.val(), note.val());
  }else{
    insertNote(title.val(), note.val());
  }
});


$("#delete_button").click(function(event){
  event.preventDefault();
  var title = $("#title");
  deleteNote(title);
});

$("#notes").click(function(event){
  if ($(event.target).is('li')) {
    var element = $(event.target);
    getNote(element.attr("data-id"));
  }
});

$("#new_button").click(function(event){
  event.preventDefault();
  newNote();
});

$("#delete_all_button").click(function(event){
   clearNotes();
 });


   connectToDB();
   createNotesTable();
   fetchNotes();

newNote();  



