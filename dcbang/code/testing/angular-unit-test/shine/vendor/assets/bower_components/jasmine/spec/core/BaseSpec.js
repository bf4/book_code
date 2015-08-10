/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
***/
describe("base.js", function() {
  describe("jasmine.MessageResult", function() {
    it("#toString should pretty-print and concatenate each part of the message", function() {
      var values = ["log", "message", 123, {key: "value"}, "FTW!"];
      var messageResult = new jasmine.MessageResult(values);
      expect(messageResult.toString()).toEqual("log message 123 { key : 'value' } FTW!");
    });
  });

  describe("jasmine.log", function() {
    it("should accept n arguments", function() {
      spyOn(jasmine.getEnv().currentSpec, 'log');
      jasmine.log(1, 2, 3);
      expect(jasmine.getEnv().currentSpec.log).toHaveBeenCalledWith(1, 2, 3);
    });
  });

  describe("jasmine.getGlobal", function() {
    it("should return the global object", function() {
      var globalObject = (function() {
        return this;
      })();

      expect(jasmine.getGlobal()).toBe(globalObject);
    });
  });
});
