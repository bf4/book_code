/***
 * Excerpted from "Rails 4 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
***/
describe("with a list of tasks", function() {

  beforeEach(function() {
    table = affix("table");
    table.affix("tr.task#task_1 a.up");
    table.affix("tr.task#task_2 a.up+a.down");
    table.affix("tr.task#task_3 a.up");
  });

  it("correctly processes an up click", function() {
    $("#task_2 .up").click();
    expect($.map($("tr"), function(item) { return $(item).attr("id") }))
        .toEqual(["task_2", "task_1", "task_3"]);
  });

});
