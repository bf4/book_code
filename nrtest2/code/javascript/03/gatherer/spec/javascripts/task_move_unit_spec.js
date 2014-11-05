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
    jasmine.addMatchers(customMatchers);
    table = affix("table");
    table.affix("tr.task#task_1 a.up");
    table.affix("tr.task#task_2 a.up+a.down");
    table.affix("tr.task#task_3 a.up");
  });

  it("identifies row from target", function() {
    expect(Project.taskFromAnchor($("#task_2 .up"))).toHaveId("task_2")
  });

  it("identifies predecessor if it exists", function() {
    expect(Project.previousTask($("#task_2"))).toHaveId("task_1");
  });

  it("returns null as a predecessor if there is none", function() {
    expect(Project.previousTask($("#task_1"))).toBeNull();
  });

  it("can swap two rows", function() {
    Project.swapRows($("#task_1"), $("#task_2"));
    expect($("tr")).toMatchDomIds(["task_2", "task_1", "task_3"]);
  });

  it("can handle up click", function() {
    Project.upClickOn($("#task_2 .up"));
    expect($("tr")).toMatchDomIds(["task_2", "task_1", "task_3"]);
  });

});
