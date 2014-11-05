/***
 * Excerpted from "Rails 4 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
***/
var Project = {

  taskFromAnchor: function(anchorElement) {
    return anchorElement.parents("tr");
  },

  previousTask: function(task_row) {
    result = task_row.prev();
    if(result.length > 0) {
      return result;
    } else {
      return null;
    }
  },

  nextTask: function(task_row) {
    result = task_row.next();
    if(result.length > 0) {
      return result;
    } else {
      return null;
    }
  },

  swapRows: function(first_row, second_row) {
    second_row.detach();
    second_row.insertBefore(first_row);
  },

  //#
  upClickOn: function(anchorElement) {
    row = Project.taskFromAnchor(anchorElement);
    previousRow = Project.previousTask(row);
    if(previousRow == null) { return };
    Project.swapRows(previousRow, row);
    Project.ajaxCall(row.attr("id"), "up");
  },

  downClickOn: function(anchorElement) {
    row = Project.taskFromAnchor(anchorElement);
    nextRow = Project.nextTask(row);
    if(previousRow == null) { return };
    Project.swapRows(row, nextRow);
    Project.ajaxCall(row.attr("id"), "down");
  },

  ajaxCall: function(domId, upOrDown) {
    taskId = domId.split("_")[1];
    $.ajax({
      url: "/tasks/" + taskId + "/" + upOrDown + ".js",
      data: { "_method": "PATCH"},
      type: "POST"
    }).done(function(data) {
      Project.successfulUpdate(data)
    }).fail(function(data) {
      Project.failedUpdate(data);
    });
  },

  successfulUpdate: function(data) {

  },

  failedUpdate: function(data) {

  }
  //
}

$(function() {
  $(document).on("click", ".up", function(event) {
    event.preventDefault();
    Project.upClickOn($(this));
  });

  $(document).on("click", ".down", function() {
    Project.downClickOn($(this));
  });
})


