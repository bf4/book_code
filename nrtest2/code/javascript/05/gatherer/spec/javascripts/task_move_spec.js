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
    this.server = sinon.fakeServer.create();
    this.server.fakeHTTPMethods = true;
  });

  afterEach(function() {
    this.server.restore;
  });

  describe("with a successful Ajax call", function() {
    beforeEach(function() {
      this.server.respondWith("PATCH", "/tasks/2/up.js",
          "{'task_id: 2, new_order: 1}");
    });

    it("invokes a callback on success", function() {
      spyOn(Project, "successfulUpdate").and.callThrough();
      $("#task_2 .up").click();
      this.server.respond()
      expect(Project.successfulUpdate).toHaveBeenCalled();
    });
  });

  describe("with an unsuccessful Ajax call", function() {

    beforeEach(function() {
      this.server.respondWith("PATCH", "/tasks/2/up.js",
          [500, {}, ""]);
    });

    it("invokes a callback on failure", function() {
      spyOn(Project, "failedUpdate").and.callThrough();
      $("#task_2 .up").click();
      this.server.respond()
      expect(Project.failedUpdate).toHaveBeenCalled();
    });
  });

  it("correctly processes an up click", function() {
    $("#task_2 .up").click();
    expect($("tr")).toMatchDomIds(["task_2", "task_1", "task_3"]);
  });

  it("correctly processes an down click", function() {
    $("#task_2 .down").click();
    expect($("tr")).toMatchDomIds(["task_1", "task_3", "task_2"]);
  });

});
