/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
describe('MenuController', function() {
  it('records which items have been clicked', function() {
    mockDiv = {};
    mockEvent = {
      element: {
        text: function() { return 'textValue'; }
      }
    };
    mockDiv.onclick = function() { };
    spyOn(mockDiv, 'onclick');
    var items = [];

    var controller = new MenuController(items);
    controller.listenTo(mockDiv);
    mockDiv.onclick.argsForCall[0][0](mockEvent);
    expect(items[0]).toBe('textValue');
  });
});
