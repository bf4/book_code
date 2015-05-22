/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
describe('Add ToDo', function () {
  var mocks = {};
  beforeEach(function () {
    loadFixtures("index.html");
    mocks.todo = "something fun";
    $('#todo').val(mocks.todo);
    ToDo.setup();
  });
  it('calls the addToDo function when create is clicked', function () { 
    spyOn(ToDo, 'addToDo');
    $('#create').click();
    expect(ToDo.addToDo).toHaveBeenCalledWith(mocks.todo);
  });
  it('triggers a click event when create is clicked.', function() {
    spyOnEvent($('#create'), 'click');
    $('#create').click();
    expect('click').toHaveBeenTriggeredOn($('#create'));
  });
});

