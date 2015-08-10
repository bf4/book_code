/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
***/
describe("jasmine.Queue", function() {
  it("should not call itself recursively, so we don't get stack overflow errors", function() {
    var queue = new jasmine.Queue(new jasmine.Env());
    queue.add(new jasmine.Block(null, function() {}));
    queue.add(new jasmine.Block(null, function() {}));
    queue.add(new jasmine.Block(null, function() {}));
    queue.add(new jasmine.Block(null, function() {}));

    var nestCount = 0;
    var maxNestCount = 0;
    var nextCallCount = 0;
    queue.next_ = function() {
      nestCount++;
      if (nestCount > maxNestCount) maxNestCount = nestCount;

      jasmine.Queue.prototype.next_.apply(queue, arguments);
      nestCount--;
    };

    queue.start();
    expect(maxNestCount).toEqual(1);
  });
});